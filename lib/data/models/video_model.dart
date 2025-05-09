class VideoModel {
  final String id;
  final String title;
  final String thumbnail;
  final int views;
  final String profileInstructor;
  final String instructor;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.views,
    required this.profileInstructor,
    required this.instructor,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      views: json['views'],
      profileInstructor: json['profile_instructor'],
      instructor: json['instructor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'views': views,
      'profile_instructor': profileInstructor,
      'instructor': instructor,
    };
  }
}
