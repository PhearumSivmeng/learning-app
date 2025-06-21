class CourseModel {
  final String technologyId;
  final String instructorId;
  final String technology;
  final String thumbnail;
  final String instructor;
  final String profile;
  final int videosCount;

  CourseModel({
    required this.technologyId,
    required this.instructorId,
    required this.technology,
    required this.thumbnail,
    required this.instructor,
    required this.profile,
    required this.videosCount,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      technologyId: json['technologyId'],
      instructorId: json['instructorId'],
      technology: json['technology'],
      thumbnail: json['thumbnail'],
      instructor: json['instructor'],
      profile: json['profile'],
      videosCount: json['videosCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'technologyId': technologyId,
      'instructorId': instructorId,
      'technology': technology,
      'thumbnail': thumbnail,
      'instructor': instructor,
      'profile': profile,
      'videosCount': videosCount,
    };
  }
}
