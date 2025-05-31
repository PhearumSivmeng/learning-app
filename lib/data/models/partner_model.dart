class PartnerModel {
  final String id;
  final String roomId;
  final String partnerName;
  final String partnerProfile;
  final String date;
  final String content;
  final String? type; // Nullable
  final int unreadCount;

  PartnerModel({
    required this.id,
    required this.roomId,
    required this.partnerName,
    required this.partnerProfile,
    required this.date,
    required this.content,
    this.type, // Nullable
    required this.unreadCount,
  });

  // Factory constructor to create a ChatModel from JSON
  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      id: json['id'],
      roomId: json['roomId'],
      partnerName: json['partnerName'],
      partnerProfile: json['partnerProfile'],
      date: json['date'],
      content: json['content'],
      type: json['type'], // Can be null
      unreadCount: json['unreadCount'],
    );
  }

  // Method to convert a ChatModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomId': roomId,
      'partnerName': partnerName,
      'partnerProfile': partnerProfile,
      'date': date,
      'content': content,
      'type': type,
      'unreadCount': unreadCount,
    };
  }
}
