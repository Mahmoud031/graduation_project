import 'package:graduation_project/features/chat/domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  ChatMessageModel({
    required super.messageId,
    required super.chatId,
    required super.senderId,
    required super.senderName,
    required super.senderType,
    required super.message,
    required super.timestamp,
    required super.status,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      messageId: json['messageId'] ?? '',
      chatId: json['chatId'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderType: json['senderType'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp']) 
          : DateTime.now(),
      status: _parseMessageStatus(json['status'] ?? 'sent'),
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      messageId: entity.messageId,
      chatId: entity.chatId,
      senderId: entity.senderId,
      senderName: entity.senderName,
      senderType: entity.senderType,
      message: entity.message,
      timestamp: entity.timestamp,
      status: entity.status,
    );
  }

  static MessageStatus _parseMessageStatus(String status) {
    switch (status) {
      case 'delivered':
        return MessageStatus.delivered;
      case 'read':
        return MessageStatus.read;
      default:
        return MessageStatus.sent;
    }
  }

  static String _messageStatusToString(MessageStatus status) {
    switch (status) {
      case MessageStatus.delivered:
        return 'delivered';
      case MessageStatus.read:
        return 'read';
      default:
        return 'sent';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'chatId': chatId,
      'senderId': senderId,
      'senderName': senderName,
      'senderType': senderType,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'status': _messageStatusToString(status),
    };
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      messageId: messageId,
      chatId: chatId,
      senderId: senderId,
      senderName: senderName,
      senderType: senderType,
      message: message,
      timestamp: timestamp,
      status: status,
    );
  }
} 