# 暖途 (WarmTrip) Flutter 应用结构

## 项目概述
暖途是一个旅行社交应用，用户可以分享旅行经历、探索目的地、使用AI助手获取旅游建议，并记录自己的旅行足迹。

## 技术栈
- Flutter 3.10.4+
- Dart
- 状态管理: setState
- 本地存储: shared_preferences
- 日期格式化: intl

## 目录结构

```
lib/
├── main.dart                    # 应用入口
├── constants/
│   └── colors.dart             # 颜色常量定义
├── data/
│   └── mock_data.dart          # 模拟数据
├── models/
│   ├── destination.dart        # 目的地模型
│   ├── footprint.dart          # 足迹模型
│   ├── message.dart            # 消息模型
│   └── post.dart               # 帖子模型
├── screens/
│   ├── home_screen.dart        # 主屏幕（包含底部导航）
│   └── tabs/
│       ├── feed_tab.dart       # 首页Tab - 热门目的地和推荐帖子
│       ├── explore_tab.dart    # 探索Tab - 搜索和分类内容
│       ├── ai_chat_tab.dart    # AI助手Tab - 智能对话
│       ├── footprint_tab.dart  # 足迹Tab - 旅行统计和时间轴
│       └── settings_tab.dart   # 设置Tab - 个人信息和应用设置
└── widgets/
    ├── bottom_nav_bar.dart     # 底部导航栏
    ├── destination_card.dart   # 目的地卡片
    ├── post_card.dart          # 帖子卡片
    └── post_modal.dart         # 发布动态弹窗
```

## 主要功能

### 1. 首页 (Feed Tab)
- 热门目的地横向滚动列表
- 推荐帖子瀑布流
- 点赞、评论、分享功能
- 发布按钮（右上角）

### 2. 探索页 (Explore Tab)
- 搜索框
- 热门话题标签
- 分类内容网格（美食、情侣、亲子、摄影）

### 3. AI助手 (AI Chat Tab)
- 智能对话界面
- 消息气泡（用户/AI）
- 实时输入和发送
- 加载动画

### 4. 足迹页 (Footprint Tab)
- 旅行统计（点亮城市、发现国家、本地足迹）
- 时间轴展示历史旅程
- 旅行回忆卡片

### 5. 设置页 (Settings Tab)
- 用户头像和信息
- 个性化设置（通知、黑名单、缓存）
- 关于暖途（协议、隐私、版本）

## 设计特点

### 颜色主题
- 主色调: 橘色 (#F97316)
- 背景色: 暖橘色 (#FFF7ED)
- 渐变色: 橘色到玫瑰红
- 强调色: 玫瑰红 (#FB7185)

### UI特性
- 圆角设计（16-32px）
- 卡片阴影效果
- 渐变背景
- 流畅的动画过渡
- iOS风格的搜索框
- 底部导航栏带有特殊AI按钮

## 数据模型

### Post (帖子)
- id: 唯一标识
- user: 用户名
- avatar: 头像URL
- location: 位置
- content: 内容
- image: 图片URL
- likes: 点赞数
- comments: 评论数
- isLiked: 是否已点赞

### Destination (目的地)
- name: 名称
- image: 图片URL
- description: 描述

### Message (消息)
- role: 角色（user/ai）
- text: 消息内容
- timestamp: 时间戳

### Footprint (足迹)
- date: 日期
- city: 城市
- title: 标题
- image: 图片URL

## 运行应用

```bash
# 安装依赖
flutter pub get

# 运行应用
flutter run

# 构建APK
flutter build apk

# 构建iOS
flutter build ios
```

## 注意事项

1. 所有图片使用网络图片（Unsplash API）
2. 不使用本地assets
3. 不需要账户登录功能
4. 不使用freezed包和part语法
5. 使用setState进行状态管理
6. 使用shared_preferences进行本地存储（预留）
7. AI对话使用模拟响应（可接入真实API）

## 未来扩展

- [ ] 接入真实的AI API
- [ ] 实现用户认证系统
- [ ] 添加图片上传功能
- [ ] 实现评论功能
- [ ] 添加地图集成
- [ ] 实现分享功能
- [ ] 添加推送通知
- [ ] 实现缓存管理
