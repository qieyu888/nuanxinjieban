class Footprint {
  final String date;
  final String city;
  final String title;
  final String image;
  final String description;
  final int days;
  final int photos;
  final List<String> tags;
  final List<String> photoGallery;

  Footprint({
    required this.date,
    required this.city,
    required this.title,
    required this.image,
    required this.description,
    required this.days,
    required this.photos,
    required this.tags,
    List<String>? photoGallery,
  }) : photoGallery = photoGallery ?? [image];

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'city': city,
      'title': title,
      'image': image,
      'description': description,
      'days': days,
      'photos': photos,
      'tags': tags,
      'photoGallery': photoGallery,
    };
  }

  factory Footprint.fromJson(Map<String, dynamic> json) {
    return Footprint(
      date: json['date'] as String,
      city: json['city'] as String,
      title: json['title'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
      days: json['days'] as int,
      photos: json['photos'] as int,
      tags: List<String>.from(json['tags'] as List),
      photoGallery: json['photoGallery'] != null 
          ? List<String>.from(json['photoGallery'] as List)
          : null,
    );
  }
}
