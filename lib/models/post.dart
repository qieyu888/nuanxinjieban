class Post {
  final String id;
  final String user;
  final String avatar;
  final String location;
  final String content;
  final String image;
  int likes;
  int comments;
  bool isLiked;

  Post({
    required this.id,
    required this.user,
    required this.avatar,
    required this.location,
    required this.content,
    required this.image,
    required this.likes,
    required this.comments,
    this.isLiked = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'avatar': avatar,
      'location': location,
      'content': content,
      'image': image,
      'likes': likes,
      'comments': comments,
      'isLiked': isLiked,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as String,
      user: json['user'] as String,
      avatar: json['avatar'] as String,
      location: json['location'] as String,
      content: json['content'] as String,
      image: json['image'] as String,
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      isLiked: json['isLiked'] as bool? ?? false,
    );
  }
}
