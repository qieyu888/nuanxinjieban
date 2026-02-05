# 暖途 (WarmTrip) - 快速开始指南

## 前置要求

- Flutter SDK 3.10.4 或更高版本
- Dart SDK
- Android Studio / Xcode（用于模拟器）
- VS Code 或 Android Studio（推荐）

## 安装步骤

### 1. 检查Flutter环境

```bash
flutter doctor
```

确保所有必需的组件都已安装。

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行应用

#### 在Android模拟器上运行

```bash
# 启动Android模拟器
flutter emulators --launch <emulator_id>

# 运行应用
flutter run
```

#### 在iOS模拟器上运行（仅macOS）

```bash
# 打开iOS模拟器
open -a Simulator

# 运行应用
flutter run
```

#### 在真实设备上运行

```bash
# 连接设备后
flutter devices  # 查看已连接的设备
flutter run -d <device_id>
```

### 4. 热重载

应用运行后，修改代码并保存，按 `r` 进行热重载，按 `R` 进行热重启。

## 应用功能演示

### 首页
1. 查看热门目的地横向滚动列表
2. 浏览推荐帖子
3. 点击❤️图标进行点赞
4. 点击右上角"发布"按钮打开发布弹窗

### 探索页
1. 使用搜索框搜索内容
2. 点击热门话题标签
3. 浏览分类内容网格

### AI助手
1. 在输入框输入旅游相关问题
2. 点击发送按钮或按回车
3. 查看AI的智能回复

### 足迹页
1. 查看旅行统计数据
2. 浏览时间轴上的旅行回忆

### 设置页
1. 查看用户信息
2. 浏览个性化设置选项
3. 查看关于暖途信息

## 项目结构

```
lib/
├── main.dart                 # 应用入口
├── constants/               # 常量定义
├── data/                    # 数据层
├── models/                  # 数据模型
├── screens/                 # 页面
│   ├── home_screen.dart
│   └── tabs/               # Tab页面
└── widgets/                # 可复用组件
```

## 自定义配置

### 修改主题颜色

编辑 `lib/constants/colors.dart`：

```dart
class AppColors {
  static const Color primary = Color(0xFFF97316);  // 修改主色调
  static const Color background = Color(0xFFFFF7ED);  // 修改背景色
  // ...
}
```

### 修改模拟数据

编辑 `lib/data/mock_data.dart`：

```dart
static List<Post> getPosts() {
  return [
    Post(
      id: '1',
      user: '你的用户名',
      // ...
    ),
  ];
}
```

### 接入真实API

在 `lib/screens/tabs/ai_chat_tab.dart` 中修改 `_sendMessage` 方法：

```dart
void _sendMessage() async {
  // 替换为真实的API调用
  final response = await http.post(
    Uri.parse('your-api-endpoint'),
    body: {'message': userMessage},
  );
  // 处理响应...
}
```

## 常见问题

### Q: 图片加载失败？
A: 确保设备/模拟器有网络连接，图片使用Unsplash的CDN。

### Q: 应用运行缓慢？
A: 在真实设备上运行会比模拟器快，或使用 `flutter run --release` 构建发布版本。

### Q: 如何添加新的Tab？
A: 
1. 在 `lib/screens/tabs/` 创建新的Tab文件
2. 在 `home_screen.dart` 的 `_tabs` 列表中添加
3. 在 `bottom_nav_bar.dart` 添加新的导航按钮

### Q: 如何持久化数据？
A: 使用已安装的 `shared_preferences` 包：

```dart
import 'package:shared_preferences/shared_preferences.dart';

// 保存数据
final prefs = await SharedPreferences.getInstance();
await prefs.setString('key', 'value');

// 读取数据
final value = prefs.getString('key');
```

## 构建发布版本

### Android APK

```bash
flutter build apk --release
```

生成的APK位于：`build/app/outputs/flutter-apk/app-release.apk`

### iOS IPA（需要Apple开发者账号）

```bash
flutter build ios --release
```

然后在Xcode中归档并上传到App Store。

## 下一步

- [ ] 接入真实的后端API
- [ ] 实现用户认证
- [ ] 添加图片上传功能
- [ ] 集成地图服务
- [ ] 添加推送通知
- [ ] 实现社交分享
- [ ] 优化性能和动画

## 技术支持

如有问题，请查看：
- Flutter官方文档：https://flutter.dev/docs
- Dart语言指南：https://dart.dev/guides
- 项目结构文档：APP_STRUCTURE.md

## 许可证

本项目仅供学习和演示使用。
