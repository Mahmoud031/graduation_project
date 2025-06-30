import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/features/chatbot/domain/entities/chatbot_message_entity.dart';

abstract class ChatbotRepo {
  Future<Either<Failure, void>> initializeChatbot(String userType);
  Future<Either<Failure, String>> sendMessage(String message);
  Future<Either<Failure, void>> resetChat();
  Future<Either<Failure, List<ChatbotMessageEntity>>> getChatHistory();
} 