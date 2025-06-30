import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/chatbot/domain/entities/chatbot_message_entity.dart';
import 'package:graduation_project/features/chatbot/domain/repos/chatbot_repo.dart';
import 'package:meta/meta.dart';

part 'chatbot_state.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  final ChatbotRepo chatbotRepo;
  
  ChatbotCubit(this.chatbotRepo) : super(ChatbotInitial());

  Future<void> initializeChatbot(String userType) async {
    emit(ChatbotLoading());
    final result = await chatbotRepo.initializeChatbot(userType);
    result.fold(
      (failure) => emit(ChatbotFailure(failure.message)),
      (_) => _loadChatHistory(),
    );
  }

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;
    
    emit(ChatbotLoading());
    final result = await chatbotRepo.sendMessage(message);
    result.fold(
      (failure) => emit(ChatbotFailure(failure.message)),
      (_) => _loadChatHistory(),
    );
  }

  Future<void> resetChat() async {
    emit(ChatbotLoading());
    final result = await chatbotRepo.resetChat();
    result.fold(
      (failure) => emit(ChatbotFailure(failure.message)),
      (_) => emit(ChatbotInitial()),
    );
  }

  Future<void> _loadChatHistory() async {
    final result = await chatbotRepo.getChatHistory();
    result.fold(
      (failure) => emit(ChatbotFailure(failure.message)),
      (messages) => emit(ChatbotMessagesLoaded(messages)),
    );
  }
} 