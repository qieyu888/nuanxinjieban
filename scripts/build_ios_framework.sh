#!/usr/bin/env bash
# 官方方式：flutter build ios-framework
# 产出可嵌入宿主 iOS 工程、并支持 App Store 上架的 XCFramework
#
# 用法:
#   ./scripts/build_ios_framework.sh
#   CODE_SIGN_IDENTITY="Apple Distribution: Your Company (TEAMID)" ./scripts/build_ios_framework.sh
#   ./scripts/build_ios_framework.sh --all   # 同时打 Debug/Profile/Release
#
# 签名说明（官方 / App Store 要求）:
# 1. 插件使用 --static：静态库只 Link，不要 Embed（尤其 FlutterPluginRegistrant）
# 2. App.xcframework / Flutter.xcframework：宿主工程 Embed & Sign
# 3. Archive 时由宿主 App 的 Apple Distribution 证书重新签名（Xcode Embed & Sign）
# 4. 本脚本可选对 Release 动态 framework 预签名，便于分发校验

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUTPUT_DIR="${OUTPUT_DIR:-$ROOT_DIR/build/ios_framework}"
BUILD_ALL=0
# 默认打完整 XCFramework（含 Flutter.xcframework），便于直接拖入宿主工程
# 若宿主已用 CocoaPods，可传 --cocoapods
USE_COCOAPODS=0

for arg in "$@"; do
  case "$arg" in
    --all) BUILD_ALL=1 ;;
    --cocoapods) USE_COCOAPODS=1 ;;
    --help|-h)
      sed -n '2,20p' "$0"
      exit 0
      ;;
  esac
done

cd "$ROOT_DIR"

echo "==> Flutter pub get"
flutter pub get

MODE_FLAGS=(--no-debug --no-profile --release)
if [[ "$BUILD_ALL" -eq 1 ]]; then
  MODE_FLAGS=(--debug --profile --release)
fi

echo "==> Build ios-framework -> $OUTPUT_DIR"
# --static: 插件打成静态 framework，宿主只 Link、不 Embed（避免 App Store 校验失败）
# 默认 --no-cocoapods: 产出 Flutter.xcframework，可直接 Embed & Sign
POD_FLAG=(--no-cocoapods)
if [[ "$USE_COCOAPODS" -eq 1 ]]; then
  POD_FLAG=(--cocoapods)
fi

rm -rf "$OUTPUT_DIR"
flutter build ios-framework \
  --output="$OUTPUT_DIR" \
  --static \
  "${POD_FLAG[@]}" \
  "${MODE_FLAGS[@]}"

# flutter build ios-framework 产出的 objective_c.framework 经常只有模拟器切片(platform=7)
# 真机链接会报: linking in dylib built for 'iOS-simulator'
# 这里补打真机切片并合成 XCFramework
fix_objective_c_xcframework() {
  local mode_dir="$1"
  local plain_fw="$mode_dir/objective_c.framework"
  local out_xcf="$mode_dir/objective_c.xcframework"

  echo "==> Fix objective_c → XCFramework (device + simulator)"

  # 打真机 Release，拿到 platform=2 的 objective_c
  flutter build ios --release --no-codesign

  local device_fw="$ROOT_DIR/build/ios/Release-iphoneos/Runner.app/Frameworks/objective_c.framework"
  if [[ ! -f "$device_fw/objective_c" ]]; then
    device_fw="$ROOT_DIR/build/ios/iphoneos/Runner.app/Frameworks/objective_c.framework"
  fi
  if [[ ! -f "$device_fw/objective_c" ]]; then
    echo "!! 未找到真机 objective_c.framework，跳过修复"
    return 1
  fi

  # 模拟器切片：优先用 ios-framework 自带的（若为 simulator），否则用已有 simulator 产物
  local sim_fw=""
  if [[ -f "$plain_fw/objective_c" ]]; then
    local plat
    plat="$(otool -l "$plain_fw/objective_c" -arch arm64 2>/dev/null | awk '/platform/{print $2; exit}')"
    if [[ "$plat" == "7" ]]; then
      sim_fw="$plain_fw"
    fi
  fi
  if [[ -z "$sim_fw" ]]; then
    sim_fw="$(find "$ROOT_DIR/build/ios" -path '*iphonesimulator*/Runner.app/Frameworks/objective_c.framework' -type d 2>/dev/null | head -n 1 || true)"
  fi
  if [[ -z "$sim_fw" || ! -f "$sim_fw/objective_c" ]]; then
    echo "!! 未找到模拟器 objective_c.framework，仅打包真机切片"
    rm -rf "$out_xcf" "$plain_fw"
    xcodebuild -create-xcframework -framework "$device_fw" -output "$out_xcf"
  else
    rm -rf "$out_xcf" "$plain_fw"
    xcodebuild -create-xcframework \
      -framework "$device_fw" \
      -framework "$sim_fw" \
      -output "$out_xcf"
  fi

  # 校验真机切片
  local device_bin="$out_xcf/ios-arm64/objective_c.framework/objective_c"
  local device_plat
  device_plat="$(otool -l "$device_bin" -arch arm64 2>/dev/null | awk '/platform/{print $2; exit}')"
  if [[ "$device_plat" != "2" ]]; then
    echo "!! objective_c 真机切片校验失败 (platform=$device_plat, 期望 2=iOS)"
    return 1
  fi
  echo "   objective_c.xcframework OK (ios-arm64 platform=2)"
}

if [[ -d "$OUTPUT_DIR/Release" ]]; then
  fix_objective_c_xcframework "$OUTPUT_DIR/Release" || true
fi

sign_frameworks() {
  local mode_dir="$1"
  local identity="$2"
  [[ -d "$mode_dir" ]] || return 0

  echo "==> Codesign ($mode_dir) with: $identity"
  # 1) 先签内层 .framework（含 image_picker_ios 等苹果名单 SDK）
  while IFS= read -r -d '' fw; do
    if [[ "$fw" == *"FlutterPluginRegistrant"* ]]; then
      continue
    fi
    codesign --force --sign "$identity" --timestamp --options runtime "$fw" 2>/dev/null \
      || codesign --force --sign "$identity" "$fw" || true
  done < <(find "$mode_dir" -name "*.framework" -type d -print0 2>/dev/null)

  # 2) 再签外层 .xcframework（ITMS-91065 要求第三方 SDK 带签名文件）
  while IFS= read -r -d '' xcf; do
    if [[ "$xcf" == *"FlutterPluginRegistrant"* ]]; then
      continue
    fi
    codesign --force --deep --sign "$identity" --timestamp "$xcf" 2>/dev/null \
      || codesign --force --deep --sign "$identity" "$xcf" || true
  done < <(find "$mode_dir" -maxdepth 1 -name "*.xcframework" -type d -print0 2>/dev/null)

  # 3) 单独的 .framework（如 objective_c.framework）
  while IFS= read -r -d '' fw; do
    codesign --force --sign "$identity" --timestamp --options runtime "$fw" 2>/dev/null \
      || codesign --force --sign "$identity" "$fw" || true
  done < <(find "$mode_dir" -maxdepth 1 -name "*.framework" -type d -print0 2>/dev/null)
}

# Release 预签名：使用 Apple Distribution（正式上架）
# 默认：本地 Lu Qiaolin；可用环境变量覆盖
# 宿主 Archive 时仍会 Embed & Sign 覆盖
if [[ -z "${CODE_SIGN_IDENTITY:-}" ]]; then
  CODE_SIGN_IDENTITY="Apple Distribution: Lu Qiaolin (XUY8B82TGM)"
  # 若该证书不在本机钥匙串，再回退到任意 Distribution
  if ! security find-identity -v -p codesigning 2>/dev/null | grep -Fq "$CODE_SIGN_IDENTITY"; then
    CODE_SIGN_IDENTITY="$(security find-identity -v -p codesigning 2>/dev/null \
      | sed -n 's/.*"\(Apple Distribution: .*\)".*/\1/p' \
      | head -n 1 || true)"
  fi
fi

if [[ -n "${CODE_SIGN_IDENTITY:-}" ]]; then
  echo "==> Using CODE_SIGN_IDENTITY=$CODE_SIGN_IDENTITY"
  sign_frameworks "$OUTPUT_DIR/Release" "$CODE_SIGN_IDENTITY"
  if [[ "$BUILD_ALL" -eq 1 ]]; then
    # Debug/Profile 可用 Development
    DEV_IDENTITY="${CODE_SIGN_IDENTITY_DEBUG:-}"
    if [[ -z "$DEV_IDENTITY" ]]; then
      DEV_IDENTITY="$(security find-identity -v -p codesigning 2>/dev/null \
        | sed -n 's/.*"\(Apple Development: .*\)".*/\1/p' \
        | head -n 1 || true)"
    fi
    if [[ -n "$DEV_IDENTITY" ]]; then
      sign_frameworks "$OUTPUT_DIR/Debug" "$DEV_IDENTITY"
      sign_frameworks "$OUTPUT_DIR/Profile" "$DEV_IDENTITY"
    fi
  fi
else
  echo "!! 未找到 Apple Distribution 证书，跳过预签名。"
  echo "   宿主工程请使用 Embed & Sign，Archive 时由 Distribution 证书签名即可上架。"
fi

# 生成宿主集成说明
cat > "$OUTPUT_DIR/INTEGRATION.txt" <<EOF
同城陌缘 Flutter XCFramework 集成说明（可 App Store 上架）
====================================================

产出目录: $OUTPUT_DIR
构建命令: flutter build ios-framework --static --no-cocoapods

一、Xcode 嵌入方式（官方 Embed & Sign）
------------------------------------------
1. 打开宿主 iOS 工程，把 Release 目录下产物拖入工程
2. Target → General → Frameworks, Libraries, and Embedded Content

   Embed & Sign（动态库，必须）:
   - App.xcframework
   - Flutter.xcframework
   - objective_c.framework

   Do Not Embed（只 Link；--static 插件，官方强制）:
   - image_picker_ios.xcframework
   - in_app_purchase_storekit.xcframework
   - shared_preferences_foundation.xcframework
   （静态库若 Embed → ITMS-91065 / Archive 失败）

3. 把输出根目录的 GeneratedPluginRegistrant.h / .m 拷进宿主工程并加入 Compile Sources
4. Build Settings → Other Linker Flags 如需可加 -ObjC
5. 宿主若用 CocoaPods，可改用: ./scripts/build_ios_framework.sh --cocoapods

二、签名（正式上架，Xcode 官方流程）
--------------------
1. 宿主 Target → Signing & Capabilities
   - Team: 上架公司账号
   - Automatically manage signing = ON（推荐）
   - Bundle ID = 正式 App ID

2. Product → Archive → Distribute App → App Store Connect
   - Signing Certificate: Apple Distribution
   - Profile: App Store Distribution

3. Embed & Sign 会在 Archive/导出时用宿主 Distribution 证书
   对 App.framework / Flutter.framework 重新签名（官方推荐）

4. 校验:
   codesign -dv --verbose=4 YourApp.app/Frameworks/App.framework
   应显示 Authority=Apple Distribution: ...

三、Swift 调用示例
------------------
import Flutter

let engine = FlutterEngine(name: "main")
engine.run()
GeneratedPluginRegistrant.register(with: engine)
let vc = FlutterViewController(engine: engine, nibName: nil, bundle: nil)
present(vc, animated: true)

四、ITMS-91065（缺少签名）防坑
------------------------------
image_picker_ios 在苹果「常用第三方 SDK」名单中。

会触发的情况:
- 宿主把 image_picker_ios.xcframework 设为 Embed / Embed Without Signing
- 最终 IPA 出现 Frameworks/image_picker_ios.framework/... 且无签名

正确做法（当前产物已按此打包）:
1. 插件为 --static 静态库 → 宿主必须 Do Not Embed（只 Link）
2. 这样 IPA 里不会出现独立 Frameworks/image_picker_ios.framework
3. 同时本脚本已对 .xcframework 外层做 Distribution 签名

校验命令:
  codesign -dv Release/image_picker_ios.xcframework
  应显示 Authority=Apple Distribution: Lu Qiaolin ...

五、注意
--------
- 只用 Release 上架；Debug framework 禁止提交
- 预签名证书可用环境变量覆盖:
  CODE_SIGN_IDENTITY="Apple Distribution: Your Co (TEAMID)" ./scripts/build_ios_framework.sh
- Flutter 3.44+ 官方新方式: flutter build swift-package --platform ios
EOF

echo ""
echo "==> Done"
echo "输出: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR"
echo ""
echo "请把 $OUTPUT_DIR/Release 下的 xcframework 嵌入宿主工程（见 INTEGRATION.txt）"
