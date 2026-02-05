class Comment {
  final String id;
  final String user;
  final String avatar;
  final String content;
  final DateTime timestamp;
  int likes;
  bool isLiked;

  Comment({
    required this.id,
    required this.user,
    required this.avatar,
    required this.content,
    required this.timestamp,
    this.likes = 0,
    this.isLiked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'avatar': avatar,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'isLiked': isLiked,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      user: json['user'] as String,
      avatar: json['avatar'] as String,
      content: json['content'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      likes: json['likes'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }
}
