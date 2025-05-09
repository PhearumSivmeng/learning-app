class UserModel {
  static const String tableName = "user";
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String phone;
  final String email;
  final String bio;
  final String profile;
  final String token;
  final String? profileCover;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.phone,
    required this.email,
    required this.bio,
    required this.profile,
    required this.token,
    this.profileCover,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        gender: json["gender"] ?? "",
        phone: json["phone"] ?? "",
        email: json["email"] ?? "",
        bio: json["bio"] ?? "",
        profile: json["profile"] ?? "",
        token: json["token"] ?? "",
        profileCover: json["profileCover"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "phone": phone,
        "email": email,
        "bio": bio,
        "profile": profile,
        "token": token,
        "profileCover": profileCover ?? "",
      };
}
