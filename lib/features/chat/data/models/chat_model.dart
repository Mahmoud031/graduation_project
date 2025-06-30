import 'package:graduation_project/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    required super.chatId,
    required super.donorId,
    required super.donorName,
    required super.ngoId,
    required super.ngoName,
    required super.lastMessageTime,
    required super.lastMessage,
    required super.lastMessageSenderId,
    required super.isRead,
    required super.unreadCount,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'] ?? '',
      donorId: json['donorId'] ?? '',
      donorName: json['donorName'] ?? '',
      ngoId: json['ngoId'] ?? '',
      ngoName: json['ngoName'] ?? '',
      lastMessageTime: json['lastMessageTime'] != null 
          ? DateTime.parse(json['lastMessageTime']) 
          : DateTime.now(),
      lastMessage: json['lastMessage'] ?? '',
      lastMessageSenderId: json['lastMessageSenderId'] ?? '',
      isRead: json['isRead'] ?? false,
      unreadCount: json['unreadCount'] ?? 0,
    );
  }

  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      chatId: entity.chatId,
      donorId: entity.donorId,
      donorName: entity.donorName,
      ngoId: entity.ngoId,
      ngoName: entity.ngoName,
      lastMessageTime: entity.lastMessageTime,
      lastMessage: entity.lastMessage,
      lastMessageSenderId: entity.lastMessageSenderId,
      isRead: entity.isRead,
      unreadCount: entity.unreadCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatId': chatId,
      'donorId': donorId,
      'donorName': donorName,
      'ngoId': ngoId,
      'ngoName': ngoName,
      'lastMessageTime': lastMessageTime.toIso8601String(),
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'isRead': isRead,
      'unreadCount': unreadCount,
    };
  }

  ChatEntity toEntity() {
    return ChatEntity(
      chatId: chatId,
      donorId: donorId,
      donorName: donorName,
      ngoId: ngoId,
      ngoName: ngoName,
      lastMessageTime: lastMessageTime,
      lastMessage: lastMessage,
      lastMessageSenderId: lastMessageSenderId,
      isRead: isRead,
      unreadCount: unreadCount,
    );
  }
} 