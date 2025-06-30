enum ChatbotMessageType { user, bot }

class ChatbotMessageEntity {
  final String id;
  final String message;
  final ChatbotMessageType type;
  final DateTime timestamp;
  final bool isError;
  
  ChatbotMessageEntity({
    required this.id,
    required this.message,
    required this.type,
    required this.timestamp,
    this.isError = false,
  });
} 