class NotificationModel {
  String? id;
  int? messageID;
  String? messageSubject;
  String? creationDate;
  String? senderID;
  String? senderName;
  int? isRead;
  int? countIsRead;
  NotificationModel({
    this.id,
    this.messageID,
    this.messageSubject,
    this.creationDate,
    this.senderID,
    this.senderName,
    this.isRead,
    this.countIsRead,

  });

  factory NotificationModel.fromJson(Map<dynamic, dynamic> json) {
    return NotificationModel(
      id: json['_id'],
      messageID: json['MessageID'],
      messageSubject: json['MessageSubject'],
      creationDate: json['CreationDate'],
      senderID: json['SenderID'],
      senderName: json['SenderName'],
      isRead: json['IsRead'],
      countIsRead: json['countIsRead'],
    );
  }
}
