import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/gemini_service.dart';
import 'package:graduation_project/features/chatbot/data/models/chatbot_message_model.dart';
import 'package:graduation_project/features/chatbot/domain/entities/chatbot_message_entity.dart';
import 'package:graduation_project/features/chatbot/domain/repos/chatbot_repo.dart';

class ChatbotRepoImpl implements ChatbotRepo {
  final GeminiService _geminiService;
  final List<ChatbotMessageEntity> _chatHistory = [];

  ChatbotRepoImpl({required GeminiService geminiService}) 
      : _geminiService = geminiService;

  @override
  Future<Either<Failure, void>> initializeChatbot(String userType) async {
    try {
      await _geminiService.initializeChatbot(userType);
      
      // Add welcome message to chat history
      final welcomeMessage = ChatbotMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: _getWelcomeMessage(userType),
        type: ChatbotMessageType.bot,
        timestamp: DateTime.now(),
      );
      _chatHistory.add(welcomeMessage);
      
      return const Right(null);
    } catch (e) {
      log('Error initializing chatbot: $e');
      return Left(ServerFailure('Failed to initialize chatbot: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String>> sendMessage(String message) async {
    try {
      // Add user message to chat history
      final userMessage = ChatbotMessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: message,
        type: ChatbotMessageType.user,
        timestamp: DateTime.now(),
      );
      _chatHistory.add(userMessage);

      // Get response from Gemini
      final response = await _geminiService.sendMessage(message);
      
      // Add bot response to chat history
      final botMessage = ChatbotMessageModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        message: response,
        type: ChatbotMessageType.bot,
        timestamp: DateTime.now(),
      );
      _chatHistory.add(botMessage);

      return Right(response);
    } catch (e) {
      log('Error sending message: $e');
      
      // Add error message to chat history
      final errorMessage = ChatbotMessageModel(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        message: 'Sorry, I encountered an error. Please try again.',
        type: ChatbotMessageType.bot,
        timestamp: DateTime.now(),
        isError: true,
      );
      _chatHistory.add(errorMessage);
      
      return Left(ServerFailure('Failed to send message: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> resetChat() async {
    try {
      _geminiService.resetChat();
      _chatHistory.clear();
      
      return const Right(null);
    } catch (e) {
      log('Error resetting chat: $e');
      return Left(ServerFailure('Failed to reset chat: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<ChatbotMessageEntity>>> getChatHistory() async {
    try {
      return Right(_chatHistory);
    } catch (e) {
      log('Error getting chat history: $e');
      return Left(ServerFailure('Failed to get chat history: ${e.toString()}'));
    }
  }

  String _getWelcomeMessage(String userType) {
    if (userType == 'donor') {
      return '''Hello! I'm your AI assistant for the medical donation platform. I'm here to help you with:

• Understanding the donation process
• Medicine donation requirements and guidelines
• Finding suitable NGOs
• Platform features and navigation
• Safety guidelines for donations

How can I assist you today?''';
    } else {
      return '''Hello! I'm your AI assistant for the medical donation platform. I'm here to help you with:

• Inventory management
• Creating medicine requests
• Donation tracking and reporting
• Platform features and tools
• Medicine distribution guidance

How can I assist you today?''';
    }
  }
} 