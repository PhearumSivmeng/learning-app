class ChatModel {
  final int currentPage;
  final int lastPage;
  final int userID;
  final String userImage;
  final int partnerId;
  final String partnerImage;
  final String partnerName;
  final List<MessageModel> records;

  ChatModel({
    required this.currentPage,
    required this.lastPage,
    required this.userID,
    required this.userImage,
    required this.partnerId,
    required this.partnerImage,
    required this.partnerName,
    required this.records,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      currentPage: json['currentPage'] as int,
      lastPage: json['lastPage'] as int,
      userID: json['userID'] as int,
      userImage: json['userImage'] as String,
      partnerId: json['partnerId'] as int,
      partnerImage: json['partnerImage'] as String,
      partnerName: json['partnerName'] as String,
      records: (json['records'] as List)
          .map((record) => MessageModel.fromJson(record))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'lastPage': lastPage,
      'userID': userID,
      'userImage': userImage,
      'partnerId': partnerId,
      'partnerImage': partnerImage,
      'partnerName': partnerName,
      'records': records.map((record) => record.toJson()).toList(),
    };
  }
}

class MessageModel {
  final int id;
  final int senderId;
  final String isRead;
  final String date;
  final String content;
  final String? type;
  final Attachments? attachments;
  final double? lat;
  final double? lng;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.isRead,
    required this.date,
    required this.content,
    this.type,
    required this.attachments,
    this.lat,
    this.lng,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      senderId: json['senderId'] as int,
      isRead: json['isRead'] as String,
      date: json['date'] as String,
      content: json['content'] as String,
      type: json['type'] as String?,
      attachments: Attachments.fromJson(json['attachments']),
      lat: json['lat'] != null ? (json['lat'] as num).toDouble() : null,
      lng: json['lng'] != null ? (json['lng'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'isRead': isRead,
      'date': date,
      'content': content,
      'type': type,
      'attachments': attachments!.toJson(),
      'lat': lat,
      'lng': lng,
    };
  }
}

class Attachments {
  final List<String> images;
  final List<String> files;

  Attachments({
    required this.images,
    required this.files,
  });

  factory Attachments.fromJson(Map<String, dynamic> json) {
    return Attachments(
      images: List<String>.from(json['images']),
      files: List<String>.from(json['files']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'images': images,
      'files': files,
    };
  }
}
