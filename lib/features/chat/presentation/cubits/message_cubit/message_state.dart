part of 'message_cubit.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}
final class MessageLoading extends MessageState {}
final class MessagesLoaded extends MessageState {
  final List<ChatMessageEntity> messages;
  MessagesLoaded(this.messages);
}
final class MessageSent extends MessageState {}
final class MessagesMarkedAsRead extends MessageState {}
final class MessageStatusUpdated extends MessageState {}
final class MessageFailure extends MessageState {
  final String message;
  MessageFailure(this.message);
} 