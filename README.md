# 暖途 (WarmTrip) 🌅

一个功能完整的旅行社交Flutter应用

## 📱 应用简介

暖途是一个以暖橘色为主题的旅行社交应用，用户可以：
- 📸 浏览和发布旅行帖子
- 🗺️ 探索热门目的地
- 🤖 使用AI助手获取旅游建议
- 👣 记录旅行足迹
- ⚙️ 管理个人设置

## ✨ 主要功能

### 🏠 首页
- 热门目的地横向滚动展示
- 推荐帖子瀑布流
- 点赞、评论、分享功能
- 一键发布动态

### 🔍 探索
- 智能搜索框
- 热门话题标签
- 分类内容网格（美食、情侣、亲子、摄影）

### 🤖 AI助手
- 智能对话界面
- 旅游推荐
- 实时响应

### 🗺️ 足迹
- 旅行统计（城市、国家、足迹数）
- 时间轴展示
- 旅行回忆相册

### ⚙️ 设置
- 个人信息展示
- 个性化设置
- 关于应用

## 🚀 快速开始

### 前置要求
- Flutter SDK 3.10.4+
- Dart SDK
- Android Studio / Xcode

### 安装运行

```bash
# 1. 克隆项目（如果从Git获取）
git clone <repository-url>
cd warmtrip

# 2. 安装依赖
flutter pub get

# 3. 运行应用
flutter run

# 4. 构建发布版本
flutter build apk --release  # Android
flutter build ios --release  # iOS
```

## 📁 项目结构

```
lib/
├── main.dart                    # 应用入口
├── constants/
│   └── colors.dart             # 颜色常量
├── data/
│   └── mock_data.dart          # 模拟数据
├── models/
│   ├── destination.dart        # 目的地模型
│   ├── footprint.dart          # 足迹模型
│   ├── message.dart            # 消息模型
│   └── post.dart               # 帖子模型
├── screens/
│   ├── home_screen.dart        # 主屏幕
│   └── tabs/
│       ├── feed_tab.dart       # 首页Tab
│       ├── explore_tab.dart    # 探索Tab
│       ├── ai_chat_tab.dart    # AI助手Tab
│       ├── footprint_tab.dart  # 足迹Tab
│       └── settings_tab.dart   # 设置Tab
└── widgets/
    ├── bottom_nav_bar.dart     # 底部导航栏
    ├── destination_card.dart   # 目的地卡片
    ├── post_card.dart          # 帖子卡片
    └── post_modal.dart         # 发布弹窗
```

## 🎨 设计特点

- **暖橘色主题**：温暖舒适的视觉体验
- **圆角设计**：现代化的UI风格
- **流畅动画**：丝滑的交互体验
- **渐变效果**：精致的视觉层次
- **响应式布局**：适配各种屏幕尺寸

## 🛠️ 技术栈

- **框架**：Flutter 3.10.4+
- **语言**：Dart
- **状态管理**：setState
- **本地存储**：shared_preferences
- **日期处理**：intl

## 📚 文档

- [应用结构说明](APP_STRUCTURE.md)
- [快速开始指南](QUICK_START.md)
- [完整文件清单](COMPLETE_FILE_LIST.md)
- [文件功能总结](FILES_SUMMARY.md)

## 🎯 功能特性

✅ 5个完整的Tab页面  
✅ 底部导航栏（带动画）  
✅ 帖子浏览和点赞  
✅ 目的地展示  
✅ AI智能对话  
✅ 旅行足迹记录  
✅ 用户设置界面  
✅ 发布动态弹窗  
✅ 搜索功能UI  
✅ 热门话题展示  
✅ 分类内容网格  
✅ 时间轴布局  
✅ 响应式设计  
✅ 流畅动画效果  

## 📸 截图

应用包含以下页面：
1. 首页 - 热门目的地和推荐帖子
2. 探索 - 搜索和分类内容
3. AI助手 - 智能对话界面
4. 足迹 - 旅行统计和时间轴
5. 设置 - 个人信息和应用设置

## 🔧 自定义配置

### 修改主题颜色
编辑 `lib/constants/colors.dart`

### 修改模拟数据
编辑 `lib/data/mock_data.dart`

### 接入真实API
在相应的Tab文件中替换模拟数据为API调用

## 📝 开发说明

- ✅ 不使用 freezed 包和 part 语法
- ✅ 使用 setState 进行状态管理
- ✅ 使用 shared_preferences 进行本地存储
- ✅ 不使用本地图片 assets/images/
- ✅ 不使用 cached_network_image
- ✅ 不需要账户功能
- ✅ 不使用外部字体
- ✅ 不使用 share_plus

## 🚧 未来计划

- [ ] 接入真实的AI API
- [ ] 实现用户认证系统
- [ ] 添加图片上传功能
- [ ] 实现评论功能
- [ ] 添加地图集成
- [ ] 实现分享功能
- [ ] 添加推送通知
- [ ] 实现缓存管理

## 📄 许可证

本项目仅供学习和演示使用。

## 🤝 贡献

欢迎提交Issue和Pull Request！

## 📞 联系方式

如有问题，请查看文档或提交Issue。

---

**Made with ❤️ using Flutter**
