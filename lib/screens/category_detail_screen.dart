import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/post.dart';
import '../data/mock_data.dart';
import '../widgets/post_card.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String categoryTitle;
  final String categoryImage;

  const CategoryDetailScreen({
    super.key,
    required this.categoryTitle,
    required this.categoryImage,
  });

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  late List<Post> _posts;
  String _sortBy = '最新';

  @override
  void initState() {
    super.initState();
    _posts = MockData.getPostsByCategory(widget.categoryTitle);
  }

  void _onLikePost(String postId) {
    setState(() {
      final post = _posts.firstWhere((p) => p.id == postId);
      if (post.isLiked) {
        post.likes--;
        post.isLiked = false;
      } else {
        post.likes++;
        post.isLiked = true;
      }
    });
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '排序方式',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              ListTile(
                leading: Icon(
                  _sortBy == '最新' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: AppColors.primary,
                ),
                title: const Text('最新'),
                onTap: () {
                  setState(() => _sortBy = '最新');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(
                  _sortBy == '最热' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                  color: AppColors.primary,
                ),
                title: const Text('最热'),
                onTap: () {
                  setState(() => _sortBy = '最热');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: AppColors.textPrimary, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.categoryImage,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      widget.categoryTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '共 ${_posts.length} 篇动态',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _showSortOptions,
                    child: Row(
                      children: [
                        Text(
                          _sortBy,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.textPrimary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final post = _posts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: PostCard(
                      post: post,
                      onLike: () => _onLikePost(post.id),
                    ),
                  );
                },
                childCount: _posts.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
