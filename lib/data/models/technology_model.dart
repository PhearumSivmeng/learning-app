class AritcleModel {
  final String id;
  final String title;
  final String shortDetails;
  final String description;
  final String thumbnail;

  AritcleModel(
      {required this.id,
      required this.title,
      required this.shortDetails,
      required this.description,
      required this.thumbnail});

  factory AritcleModel.fromJson(Map<String, dynamic> json) {
    return AritcleModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      shortDetails: json['shortDetails'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'shortDetails': shortDetails,
      'description': description,
      'thumbnail': thumbnail,
    };
  }
}
