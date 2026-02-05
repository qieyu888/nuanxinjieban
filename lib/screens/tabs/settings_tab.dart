import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../../constants/colors.dart';
import '../../data/mock_data.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late String _randomQuote;

  @override
  void initState() {
    super.initState();
    final quotes = MockData.getQuotes();
    _randomQuote = quotes[Random().nextInt(quotes.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // 用户信息卡片
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.warmGradient,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              'https://api.dicebear.com/7.x/avataaars/svg?seed=WarmTraveler',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.person,
                                    size: 40,
                                    color: AppColors.primary,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '暖友_7248',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '" $_randomQuote "',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // 通知设置
              _buildSection(
                '通知设置',
                [
                  _SettingItem(
                    icon: Icons.notifications_outlined,
                    label: '消息通知',
                    value: '已开启',
                    onTap: () => _showNotificationSettings(context),
                  ),
                  _SettingItem(
                    icon: Icons.volume_up_outlined,
                    label: '声音与震动',
                    onTap: () => _showSoundSettings(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 隐私设置
              _buildSection(
                '隐私设置',
                [
                  _SettingItem(
                    icon: Icons.visibility_outlined,
                    label: '隐私设置',
                    onTap: () => _showPrivacySettings(context),
                  ),
                  _SettingItem(
                    icon: Icons.block_outlined,
                    label: '黑名单管理',
                    onTap: () => _showBlockList(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 通用设置
              _buildSection(
                '通用设置',
                [
                  _SettingItem(
                    icon: Icons.storage_outlined,
                    label: '清除缓存',
                    value: '124.5 MB',
                    onTap: () => _showClearCache(context),
                  ),
                  _SettingItem(
                    icon: Icons.feedback_outlined,
                    label: '意见反馈',
                    onTap: () => _showFeedback(context),
                  ),
                  _SettingItem(
                    icon: Icons.help_outline,
                    label: '帮助中心',
                    onTap: () => _showHelpCenter(context),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // 关于
              _buildSection(
                '关于',
                [
                  _SettingItem(
                    icon: Icons.description_outlined,
                    label: '用户协议',
                    onTap: () => _showUserAgreement(context),
                  ),
                  _SettingItem(
                    icon: Icons.privacy_tip_outlined,
                    label: '隐私政策',
                    onTap: () => _showPrivacyPolicy(context),
                  ),
                  _SettingItem(
                    icon: Icons.info_outline,
                    label: '关于暖途',
                    value: 'v1.0.0',
                    onTap: () => _showAbout(context),
                  ),
                  _SettingItem(
                    icon: Icons.refresh,
                    label: '重新查看引导',
                    onTap: () => _resetOnboarding(context),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // 底部信息
              Column(
                children: [
                  Text(
                    'WARMTRIP',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textLight.withValues(alpha: 0.5),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 32,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.borderLight,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<_SettingItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == items.length - 1;

              return InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.vertical(
                  top: index == 0 ? const Radius.circular(16) : Radius.zero,
                  bottom: isLast ? const Radius.circular(16) : Radius.zero,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: isLast
                        ? null
                        : const Border(
                            bottom: BorderSide(color: AppColors.borderLight),
                          ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFED7AA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          item.icon,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.label,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      if (item.value != null)
                        Text(
                          item.value!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textLight,
                          ),
                        ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.chevron_right,
                        size: 18,
                        color: AppColors.textLight,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // 通知设置
  void _showNotificationSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '消息通知',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildSwitchItem('接收新消息通知', true),
            _buildSwitchItem('接收点赞通知', true),
            _buildSwitchItem('接收评论通知', true),
            _buildSwitchItem('接收关注通知', false),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchItem(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
          ),
          Switch(
            value: value,
            onChanged: (val) {},
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            thumbColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primary;
              }
              return Colors.grey;
            }),
          ),
        ],
      ),
    );
  }

  // 声音设置
  void _showSoundSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '声音与震动',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildSwitchItem('消息提示音', true),
            _buildSwitchItem('震动反馈', true),
            _buildSwitchItem('按键音', false),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // 隐私设置
  void _showPrivacySettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '隐私设置',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildSwitchItem('允许陌生人查看我的足迹', true),
            _buildSwitchItem('允许陌生人评论我的帖子', true),
            _buildSwitchItem('在线状态对所有人可见', false),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // 黑名单
  void _showBlockList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '黑名单管理',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '暂无黑名单用户',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('关闭'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 清除缓存
  void _showClearCache(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('清除缓存'),
        content: const Text('确定要清除 124.5 MB 的缓存数据吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('缓存清除成功')),
              );
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  // 意见反馈
  void _showFeedback(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '意见反馈',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '您的反馈对我们很重要',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '请输入您的意见或建议...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.borderLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('感谢您的反馈！')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('提交反馈'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 帮助中心
  void _showHelpCenter(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '帮助中心',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildHelpItem(Icons.question_answer, '常见问题', () {
              Navigator.pop(context);
              _showSimpleDialog(context, '常见问题', 
                '1. 如何发布帖子？\n点击首页的"+"按钮即可发布\n\n2. 如何查看足迹？\n在足迹页面可以查看所有旅行记录\n\n3. 如何使用AI助手？\n在AI助手页面直接输入问题即可');
            }),
            _buildHelpItem(Icons.email_outlined, '联系客服', () {
              Navigator.pop(context);
              _showSimpleDialog(context, '联系客服', '客服邮箱：support@warmtrip.com\n工作时间：9:00-18:00');
            }),
            _buildHelpItem(Icons.bug_report_outlined, '问题反馈', () {
              Navigator.pop(context);
              _showFeedback(context);
            }),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textLight, size: 20),
          ],
        ),
      ),
    );
  }

  // 用户协议
  void _showUserAgreement(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('用户协议'),
        content: const SingleChildScrollView(
          child: Text(
            '暖途用户协议\n\n'
            '欢迎使用暖途！\n\n'
            '1. 服务条款\n'
            '暖途是一个旅行社交平台，致力于为用户提供优质的旅行分享和交流服务。\n\n'
            '2. 用户权利\n'
            '用户有权发布旅行内容、评论互动、使用AI助手等功能。\n\n'
            '3. 用户义务\n'
            '用户应遵守法律法规，不得发布违法违规内容。\n\n'
            '4. 隐私保护\n'
            '我们重视用户隐私，详见隐私政策。\n\n'
            '5. 免责声明\n'
            '用户发布的内容由用户自行负责。',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('我知道了'),
          ),
        ],
      ),
    );
  }

  // 隐私政策
  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('隐私政策'),
        content: const SingleChildScrollView(
          child: Text(
            '暖途隐私政策\n\n'
            '更新日期：2024年1月\n\n'
            '1. 信息收集\n'
            '我们会收集您的基本信息、使用数据等，用于提供更好的服务。\n\n'
            '2. 信息使用\n'
            '您的信息仅用于改善服务体验，不会用于其他商业目的。\n\n'
            '3. 信息保护\n'
            '我们采用行业标准的安全措施保护您的信息。\n\n'
            '4. 信息共享\n'
            '未经您同意，我们不会与第三方共享您的个人信息。\n\n'
            '5. 您的权利\n'
            '您有权查看、修改或删除您的个人信息。',
            style: TextStyle(fontSize: 14, height: 1.6),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('我知道了'),
          ),
        ],
      ),
    );
  }

  // 关于我们
  void _showAbout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('关于暖途'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                gradient: AppColors.warmGradient,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.travel_explore,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '暖途',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'v1.0.0',
              style: TextStyle(
                fontSize: 12,
                color: AppColors.textLight,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '一个温暖的旅行社交平台\n记录你的每一次出发\n\n让旅行更有温度\n让回忆更加美好',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              '© 2024 WarmTrip. All rights reserved.',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textLight,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  // 通用对话框
  void _showSimpleDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  // 重置引导页
  void _resetOnboarding(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('重新查看引导'),
        content: const Text('重启应用后将重新显示引导页面和登录页面'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('hasCompletedOnboarding');
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('已重置，请重启应用查看引导页'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback? onTap;

  _SettingItem({
    required this.icon,
    required this.label,
    this.value,
    this.onTap,
  });
}
