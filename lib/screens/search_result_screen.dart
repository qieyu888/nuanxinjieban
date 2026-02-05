import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/post.dart';
import '../models/destination.dart';
import '../data/mock_data.dart';
import '../widgets/post_card.dart';
import '../widgets/destination_card.dart';

class SearchResultScreen extends StatefulWidget {
  final String keyword;

  const SearchResultScreen({
    super.key,
    required this.keyword,
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchController;
  late List<Post> _filteredPosts;
  late List<Destination> _filteredDestinations;
  late List<String> _searchHistory;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController = TextEditingController(text: widget.keyword);
    _searchHistory = ['大理', '西藏', '成都', '三亚'];
    _performSearch(widget.keyword);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String keyword) {
    final allPosts = MockData.getPosts();
    final allDestinations = MockData.getDestinations();

    setState(() {
      _filteredPosts = allPosts.where((post) {
        return post.content.contains(keyword) ||
            post.location.contains(keyword) ||
            post.user.contains(keyword);
      }).toList();

      _filteredDestinations = allDestinations.where((dest) {
        return dest.name.contains(keyword) ||
            dest.description.contains(keyword);
      }).toList();
    });
  }

  void _onLikePost(String postId) {
    setState(() {
      final post = _filteredPosts.firstWhere((p) => p.id == postId);
      if (post.isLiked) {
        post.likes--;
        post.isLiked = false;
      } else {
        post.likes++;
        post.isLiked = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: false,
            decoration: const InputDecoration(
              hintText: '搜索目的地、攻略、话题...',
              hintStyle: TextStyle(
                color: AppColors.textLight,
                fontSize: 14,
              ),
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textLight,
                size: 20,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                _performSearch(value.trim());
              }
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              indicatorWeight: 3,
              tabs: [
                Tab(text: '动态 (${_filteredPosts.length})'),
                Tab(text: '目的地 (${_filteredDestinations.length})'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 动态列表
                _filteredPosts.isEmpty
                    ? _buildEmptyState('暂无相关动态')
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredPosts.length,
                        itemBuilder: (context, index) {
                          final post = _filteredPosts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: PostCard(
                              post: post,
                              onLike: () => _onLikePost(post.id),
                            ),
                          );
                        },
                      ),
                // 目的地列表
                _filteredDestinations.isEmpty
                    ? _buildEmptyState('暂无相关目的地')
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: _filteredDestinations.length,
                        itemBuilder: (context, index) {
                          return DestinationCard(
                            destination: _filteredDestinations[index],
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: AppColors.textLight.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textLight,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            '搜索历史',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _searchHistory.map((keyword) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = keyword;
                  _performSearch(keyword);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFED7AA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    keyword,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFEA580C),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
