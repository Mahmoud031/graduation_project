enum MessageStatus { sent, delivered, read }

class ChatMessageEntity {
  final String messageId;
  final String chatId;
  final String senderId;
  final String senderName;
  final String senderType; // 'donor' or 'ngo'
  final String message;
  final DateTime timestamp;
  final MessageStatus status;
  
  ChatMessageEntity({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.senderType,
    required this.message,
    required this.timestamp,
    required this.status,
  });
} 