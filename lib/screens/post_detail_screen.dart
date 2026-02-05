import 'package:flutter/material.dart';
import 'dart:math';
import '../constants/colors.dart';
import '../models/post.dart';
import '../models/comment.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({
    super.key,
    required this.post,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late List<Comment> _comments;
  late Post _post;

  @override
  void initState() {
    super.initState();
    _post = widget.post;
    _comments = _generateMockComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Comment> _generateMockComments() {
    final random = Random();
    final commentCount = _post.comments;
    final List<Comment> comments = [];

    final sampleComments = [
      '太美了！我也想去！',
      '照片拍得真好👍',
      '请问什么时候去最合适？',
      '收藏了，下次一定去',
      '风景绝美，羡慕！',
      '有攻略吗？求分享',
      '这个地方真的值得一去',
      '拍照技术太棒了',
      '好想去啊，可惜没时间',
      '已加入旅行清单',
      '景色太震撼了',
      '下个月就去！',
    ];

    for (int i = 0; i < commentCount; i++) {
      comments.add(
        Comment(
          id: 'comment_$i',
          user: '用户${random.nextInt(9999)}',
          avatar: 'https://i.pravatar.cc/150?img=${random.nextInt(70) + 1}',
          content: sampleComments[random.nextInt(sampleComments.length)],
          timestamp: DateTime.now().subtract(Duration(hours: random.nextInt(48))),
          likes: random.nextInt(50),
          isLiked: random.nextBool(),
        ),
      );
    }

    return comments;
  }

  void _toggleLike() {
    setState(() {
      if (_post.isLiked) {
        _post.likes--;
        _post.isLiked = false;
      } else {
        _post.likes++;
        _post.isLiked = true;
      }
    });
  }

  void _toggleCommentLike(Comment comment) {
    setState(() {
      if (comment.isLiked) {
        comment.likes--;
        comment.isLiked = false;
      } else {
        comment.likes++;
        comment.isLiked = true;
      }
    });
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      _comments.insert(
        0,
        Comment(
          id: 'comment_${DateTime.now().millisecondsSinceEpoch}',
          user: '我',
          avatar: 'https://i.pravatar.cc/150?img=1',
          content: _commentController.text.trim(),
          timestamp: DateTime.now(),
          likes: 0,
          isLiked: false,
        ),
      );
      _post.comments++;
      _commentController.clear();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return '刚刚';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else {
      return '${timestamp.month}-${timestamp.day}';
    }
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
          onPressed: () => Navigator.pop(context, _post),
        ),
        title: const Text(
          '帖子详情',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 帖子内容
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 用户信息
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.borderLight,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  _post.avatar,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: AppColors.primary,
                                      child: Center(
                                        child: Text(
                                          _post.user.substring(0, 1),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _post.user,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 12,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        _post.location,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // 图片
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: AspectRatio(
                            aspectRatio: 4 / 5,
                            child: Image.network(
                              _post.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 内容
                        Text(
                          _post.content,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // 点赞和评论
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _toggleLike,
                              child: Row(
                                children: [
                                  Icon(
                                    _post.isLiked ? Icons.favorite : Icons.favorite_border,
                                    size: 24,
                                    color: _post.isLiked ? Colors.red : AppColors.textPrimary,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _post.likes.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Row(
                              children: [
                                const Icon(
                                  Icons.chat_bubble_outline,
                                  size: 24,
                                  color: AppColors.textPrimary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _post.comments.toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 评论列表
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '评论 ${_comments.length}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_comments.isEmpty)
                          const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32),
                              child: Text(
                                '还没有评论，快来抢沙发吧~',
                                style: TextStyle(
                                  color: AppColors.textLight,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _comments.length,
                            itemBuilder: (context, index) {
                              final comment = _comments[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.borderLight,
                                      ),
                                      child: ClipOval(
                                        child: Image.network(
                                          comment.avatar,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: AppColors.primary,
                                              child: Center(
                                                child: Text(
                                                  comment.user.substring(0, 1),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                comment.user,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                _formatTimestamp(comment.timestamp),
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors.textLight,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            comment.content,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              color: AppColors.textPrimary,
                                              height: 1.4,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          GestureDetector(
                                            onTap: () => _toggleCommentLike(comment),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  comment.isLiked
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                                  size: 16,
                                                  color: comment.isLiked
                                                      ? Colors.red
                                                      : AppColors.textLight,
                                                ),
                                                if (comment.likes > 0) ...[
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    comment.likes.toString(),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: comment.isLiked
                                                          ? Colors.red
                                                          : AppColors.textLight,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          // 评论输入框
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: AppColors.borderLight),
              ),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFED7AA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: '说点什么...',
                          hintStyle: TextStyle(
                            color: AppColors.textLight,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                        ),
                        onSubmitted: (_) => _addComment(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _addComment,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
