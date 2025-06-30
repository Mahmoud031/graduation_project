class ChatEntity {
  final String chatId;
  final String donorId;
  final String donorName;
  final String ngoId;
  final String ngoName;
  final DateTime lastMessageTime;
  final String lastMessage;
  final String lastMessageSenderId;
  final bool isRead;
  final int unreadCount;
  
  ChatEntity({
    required this.chatId,
    required this.donorId,
    required this.donorName,
    required this.ngoId,
    required this.ngoName,
    required this.lastMessageTime,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.isRead,
    required this.unreadCount,
  });
} 