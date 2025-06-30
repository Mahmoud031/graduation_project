import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/chat/domain/entities/chat_entity.dart';
import 'package:graduation_project/features/chat/domain/repos/chat_repo.dart';
import 'package:meta/meta.dart';
import 'dart:async';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  StreamSubscription? _chatsSubscription;
  bool _isClosed = false;
  
  ChatCubit(this.chatRepo) : super(ChatInitial());

  @override
  void emit(ChatState state) {
    if (!_isClosed) {
      super.emit(state);
    }
  }

  Future<void> getChats(String userId, String userType) async {
    emit(ChatLoading());
    final result = await chatRepo.getChats(userId, userType);
    result.fold(
      (failure) => emit(ChatFailure(failure.message)),
      (chats) => emit(ChatsLoaded(chats)),
    );
  }

  Future<void> createChat(String donorId, String donorName, String ngoId, String ngoName) async {
    emit(ChatLoading());
    final result = await chatRepo.createChat(donorId, donorName, ngoId, ngoName);
    result.fold(
      (failure) => emit(ChatFailure(failure.message)),
      (chatId) => emit(ChatCreated(chatId)),
    );
  }

  void listenToChats(String userId, String userType) {
    _chatsSubscription?.cancel();
    _chatsSubscription = chatRepo.listenToChats(userId, userType).listen(
      (chats) {
        if (!_isClosed) emit(ChatsLoaded(chats));
      },
      onError: (error) {
        if (!_isClosed) emit(ChatFailure(error.toString()));
      },
    );
  }

  @override
  Future<void> close() {
    _isClosed = true;
    _chatsSubscription?.cancel();
    return super.close();
  }
} 