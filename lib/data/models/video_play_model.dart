class VideoDetails {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String video;
  final int views;
  final String category;
  final String technology;
  final String instructor;
  final String profile;

  VideoDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.video,
    required this.views,
    required this.category,
    required this.technology,
    required this.instructor,
    required this.profile,
  });

  factory VideoDetails.fromJson(Map<String, dynamic> json) {
    return VideoDetails(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      video: json['video'] ?? '',
      views: json['views'] ?? 0,
      category: json['category'] ?? '',
      technology: json['technology'] ?? '',
      instructor: json['instructor'] ?? '',
      profile: json['profile'] ?? '',
    );
  }
}
