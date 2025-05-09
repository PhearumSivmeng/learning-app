class SlideModel {
  final String id;
  final String title;
  final String description;
  String thumbnail;

  SlideModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory SlideModel.fromJson(Map<String, dynamic> json) {
    return SlideModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
    };
  }
}
