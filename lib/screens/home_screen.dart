import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'tabs/feed_tab.dart';
import 'tabs/explore_tab.dart';
import 'tabs/ai_chat_tab.dart';
import 'tabs/footprint_tab.dart';
import 'tabs/settings_tab.dart';
import '../widgets/post_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _showPostModal = false;
  final _feedTabKey = GlobalKey<FeedTabState>();

  late final List<Widget> _tabs;

  final List<String> _titles = ['发现', '探索', 'AI助理', '足迹', '设置'];

  @override
  void initState() {
    super.initState();
    _tabs = [
      FeedTab(key: _feedTabKey),
      const ExploreTab(),
      const AIChatTab(),
      const FootprintTab(),
      const SettingsTab(),
    ];
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showPostDialog() {
    setState(() {
      _showPostModal = true;
    });
  }

  void _closePostDialog() {
    setState(() {
      _showPostModal = false;
    });
  }

  void _handlePublish(String content, String? location, List<String> imagePaths) {
    _feedTabKey.currentState?.addNewPost(content, location, imagePaths);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              if (_currentIndex != 2)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    border: const Border(
                      bottom: BorderSide(color: AppColors.borderLight, width: 1),
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _titles[_currentIndex],
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (_currentIndex == 0)
                            GestureDetector(
                              onTap: _showPostDialog,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  gradient: AppColors.warmGradient,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  '发布',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          else
                            const SizedBox(width: 48, height: 6),
                        ],
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: _tabs[_currentIndex],
              ),
            ],
          ),
          if (_showPostModal)
            PostModal(
              onClose: _closePostDialog,
              onPublish: _handlePublish,
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}
