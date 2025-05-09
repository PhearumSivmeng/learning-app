class Tag {
  final String tagName;

  Tag({required this.tagName});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(tagName: json['tagName']);
  }

  Map<String, dynamic> toJson() {
    return {
      'tagName': tagName,
    };
  }
}

class QuestionModel {
  final String id;
  final String title;
  final String description;
  final List<Tag> tags;
  final String user;
  final String profile;
  final int answer;

  QuestionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.tags,
    required this.user,
    required this.profile,
    required this.answer,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      tags: (json['tags'] as List).map((e) => Tag.fromJson(e)).toList(),
      user: json['user'],
      profile: json['profile'],
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'tags': tags.map((e) => e.toJson()).toList(),
      'user': user,
      'profile': profile,
      'answer': answer,
    };
  }
}
