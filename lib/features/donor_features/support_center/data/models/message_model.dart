import 'package:graduation_project/features/donor_features/support_center/domain/entities/message_entity.dart';

class MessageModel {
  final String subject;
  final String message;
  final String userId;
  final String userName;

  MessageModel({
    required this.subject, 
    required this.message,
    required this.userId,
    required this.userName,
  });

  factory MessageModel.fromEntity(MessageEntity sendMessageEntity) {
    return MessageModel(
      subject: sendMessageEntity.subject,
      message: sendMessageEntity.message,
      userId: sendMessageEntity.userId,
      userName: sendMessageEntity.userName,
    );
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      subject: json['subject'],
      message: json['message'],
      userId: json['userId'],
      userName: json['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'message': message,
      'userId': userId,
      'userName': userName,
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      subject: subject,
      message: message,
      userId: userId,
      userName: userName,
    );
  }
}

