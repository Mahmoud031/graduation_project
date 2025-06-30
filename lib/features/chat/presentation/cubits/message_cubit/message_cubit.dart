import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_message_entity.dart';
import 'package:graduation_project/features/chat/domain/repos/chat_repo.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ChatRepo chatRepo;
  StreamSubscription? _messagesSubscription;
  bool _isClosed = false;
  
  MessageCubit(this.chatRepo) : super(MessageInitial());

  @override
  void emit(MessageState state) {
    if (!_isClosed) {
      super.emit(state);
    }
  }

  Future<void> getMessages(String chatId) async {
    emit(MessageLoading());
    final result = await chatRepo.getChatMessages(chatId);
    result.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (messages) => emit(MessagesLoaded(messages)),
    );
  }

  Future<void> sendMessage(ChatMessageEntity message) async {
    emit(MessageLoading());
    final result = await chatRepo.sendMessage(message);
    result.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (_) => emit(MessageSent()),
    );
  }

  Future<void> markAsRead(String chatId, String userId) async {
    final result = await chatRepo.markMessagesAsRead(chatId, userId);
    result.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (_) => emit(MessagesMarkedAsRead()),
    );
  }

  void listenToMessages(String chatId) {
    _messagesSubscription?.cancel();
    _messagesSubscription = chatRepo.listenToMessages(chatId).listen(
      (messages) {
        if (!_isClosed) emit(MessagesLoaded(messages));
      },
      onError: (error) {
        if (!_isClosed) emit(MessageFailure(error.toString()));
      },
    );
  }

  Future<void> updateMessageStatus(String messageId, String status) async {
    final result = await chatRepo.updateMessageStatus(messageId, status);
    result.fold(
      (failure) => emit(MessageFailure(failure.message)),
      (_) => emit(MessageStatusUpdated()),
    );
  }

  @override
  Future<void> close() {
    _isClosed = true;
    _messagesSubscription?.cancel();
    return super.close();
  }
} 