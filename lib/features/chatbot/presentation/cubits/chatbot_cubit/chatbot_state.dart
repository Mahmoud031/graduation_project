part of 'chatbot_cubit.dart';

@immutable
sealed class ChatbotState {}

final class ChatbotInitial extends ChatbotState {}
final class ChatbotLoading extends ChatbotState {}
final class ChatbotMessagesLoaded extends ChatbotState {
  final List<ChatbotMessageEntity> messages;
  ChatbotMessagesLoaded(this.messages);
}
final class ChatbotFailure extends ChatbotState {
  final String message;
  ChatbotFailure(this.message);
} 