class UserActiveModel {
  final String id;
  final String name;
  final String gender;
  final String? profile; // Nullable profile

  UserActiveModel({
    required this.id,
    required this.name,
    required this.gender,
    this.profile, // Nullable
  });

  factory UserActiveModel.fromJson(Map<String, dynamic> json) {
    return UserActiveModel(
      id: json['id'] as String,
      name: json['name'] as String,
      gender: json['gender'] as String,
      profile: json['profile'] as String?, // Handle null case
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'profile': profile, // Can be null
    };
  }
}
