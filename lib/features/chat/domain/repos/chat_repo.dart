import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_entity.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_message_entity.dart';

abstract class ChatRepo {
  Future<Either<Failure, List<ChatEntity>>> getChats(String userId, String userType);
  Future<Either<Failure, List<ChatMessageEntity>>> getChatMessages(String chatId);
  Future<Either<Failure, void>> sendMessage(ChatMessageEntity message);
  Future<Either<Failure, String>> createChat(String donorId, String donorName, String ngoId, String ngoName);
  Future<Either<Failure, void>> markMessagesAsRead(String chatId, String userId);
  Future<Either<Failure, void>> updateMessageStatus(String messageId, String status);
  Stream<List<ChatMessageEntity>> listenToMessages(String chatId);
  Stream<List<ChatEntity>> listenToChats(String userId, String userType);
} 