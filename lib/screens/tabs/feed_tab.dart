import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/post.dart';
import '../../models/destination.dart';
import '../../widgets/post_card.dart';
import '../../widgets/destination_card.dart';

class FeedTab extends StatefulWidget {
  final Function(String content, String? location)? onNewPost;
  
  const FeedTab({super.key, this.onNewPost});

  @override
  State<FeedTab> createState() => FeedTabState();
}

class FeedTabState extends State<FeedTab> {
  late List<Post> _posts;
  late List<Destination> _destinations;

  @override
  void initState() {
    super.initState();
    _posts = MockData.getPosts();
    _destinations = MockData.getDestinations();
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

  void addNewPost(String content, String? location, List<String> imagePaths) {
    // 使用第一张图片，如果没有图片则使用默认图片
    final imageUrl = imagePaths.isNotEmpty 
        ? imagePaths[0] 
        : 'https://images.pexels.com/photos/1659438/pexels-photo-1659438.jpeg?auto=compress&cs=tinysrgb&w=800';
    
    final newPost = Post(
      id: 'post_${DateTime.now().millisecondsSinceEpoch}',
      user: '我',
      avatar: 'https://i.pravatar.cc/150?img=1',
      content: content,
      image: imageUrl,
      location: location ?? '',
      likes: 0,
      comments: 0,
      isLiked: false,
    );

    setState(() {
      _posts.insert(0, newPost);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '热门',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 224,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: _destinations.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < _destinations.length - 1 ? 16 : 0,
                  ),
                  child: DestinationCard(destination: _destinations[index]),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              '推荐',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _posts.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: PostCard(
                  post: _posts[index],
                  onLike: () => _onLikePost(_posts[index].id),
                ),
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
