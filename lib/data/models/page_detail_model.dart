class PageDetailModel {
  final String name;
  final String logo;
  final String description;
  final String phoneContact;
  final String emailContact;

  PageDetailModel({
    required this.name,
    required this.logo,
    required this.description,
    required this.phoneContact,
    required this.emailContact,
  });

  // Factory constructor to create an instance from JSON
  factory PageDetailModel.fromJson(Map<String, dynamic> json) {
    return PageDetailModel(
      name: json['name'] ?? '',
      logo: json['logo'] ?? '',
      description: json['description'] ?? '',
      phoneContact: json['phone_contact'] ?? '',
      emailContact: json['email_contact'] ?? '',
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'logo': logo,
      'description': description,
      'phone_contact': phoneContact,
      'email_contact': emailContact,
    };
  }
}
