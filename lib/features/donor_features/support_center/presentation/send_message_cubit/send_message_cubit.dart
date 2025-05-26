import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/entities/message_entity.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';
import 'package:meta/meta.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit(this.messageRepo) : super(SendMessageInitial());
  final MessageRepo messageRepo;
  Future<void> sendMessage(MessageEntity sendMessageEntity) async {
    emit(SendMessageLoading());
    var result = await messageRepo.sendMessage(sendMessageEntity);
    result.fold((f) {
      emit(
        SendMessageFailure(f.message),
      );
    }, (r) {
      emit(SendMessageSuccess());
    });
  }
}
