class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String logo;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
  });
  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'logo': logo,
    };
  }
}
