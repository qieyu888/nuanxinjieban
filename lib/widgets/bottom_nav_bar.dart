import 'package:flutter/material.dart';
import '../constants/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        border: const Border(
          top: BorderSide(color: AppColors.borderLight),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabButton(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: '首页',
                index: 0,
              ),
              _buildTabButton(
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: '探索',
                index: 1,
              ),
              _buildTabButton(
                icon: Icons.auto_awesome_outlined,
                activeIcon: Icons.auto_awesome,
                label: 'AI助理',
                index: 2,
                isSpecial: true,
              ),
              _buildTabButton(
                icon: Icons.map_outlined,
                activeIcon: Icons.map,
                label: '足迹',
                index: 3,
              ),
              _buildTabButton(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings,
                label: '设置',
                index: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    bool isSpecial = false,
  }) {
    final isActive = currentIndex == index;

    return GestureDetector(
      onTap: () => onTabChanged(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: isActive ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSpecial && isActive)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  activeIcon,
                  size: 24,
                  color: Colors.white,
                ),
              )
            else
              Icon(
                isActive ? activeIcon : icon,
                size: 24,
                color: isActive ? AppColors.primary : AppColors.textLight,
              ),
            const SizedBox(height: 4),
            Text(
              isSpecial && isActive ? 'AI助手' : (isSpecial ? 'AI助你' : label),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isActive ? AppColors.primary : AppColors.textLight,
              ),
            ),
            if (isActive && !isSpecial)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
