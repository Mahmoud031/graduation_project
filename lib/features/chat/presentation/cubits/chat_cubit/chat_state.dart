part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}
final class ChatLoading extends ChatState {}
final class ChatsLoaded extends ChatState {
  final List<ChatEntity> chats;
  ChatsLoaded(this.chats);
}
final class ChatCreated extends ChatState {
  final String chatId;
  ChatCreated(this.chatId);
}
final class ChatFailure extends ChatState {
  final String message;
  ChatFailure(this.message);
} 