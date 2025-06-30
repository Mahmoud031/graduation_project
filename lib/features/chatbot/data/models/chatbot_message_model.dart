import 'package:graduation_project/features/chatbot/domain/entities/chatbot_message_entity.dart';

class ChatbotMessageModel extends ChatbotMessageEntity {
  ChatbotMessageModel({
    required super.id,
    required super.message,
    required super.type,
    required super.timestamp,
    super.isError = false,
  });

  factory ChatbotMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatbotMessageModel(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      type: _parseMessageType(json['type'] ?? 'user'),
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp']) 
          : DateTime.now(),
      isError: json['isError'] ?? false,
    );
  }

  factory ChatbotMessageModel.fromEntity(ChatbotMessageEntity entity) {
    return ChatbotMessageModel(
      id: entity.id,
      message: entity.message,
      type: entity.type,
      timestamp: entity.timestamp,
      isError: entity.isError,
    );
  }

  static ChatbotMessageType _parseMessageType(String type) {
    switch (type) {
      case 'bot':
        return ChatbotMessageType.bot;
      default:
        return ChatbotMessageType.user;
    }
  }

  static String _messageTypeToString(ChatbotMessageType type) {
    switch (type) {
      case ChatbotMessageType.bot:
        return 'bot';
      default:
        return 'user';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': _messageTypeToString(type),
      'timestamp': timestamp.toIso8601String(),
      'isError': isError,
    };
  }

  ChatbotMessageEntity toEntity() {
    return ChatbotMessageEntity(
      id: id,
      message: message,
      type: type,
      timestamp: timestamp,
      isError: isError,
    );
  }
} 