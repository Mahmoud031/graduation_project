import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/donor_features/support_center/domain/repos/message_repo.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/ngo_message_entity.dart';

part 'send_ngo_message_state.dart';

class SendNgoMessageCubit extends Cubit<SendNgoMessageState> {
  SendNgoMessageCubit(this.messageRepo) : super(SendNgoMessageInitial());
  final MessageRepo messageRepo;
  Future<void> sendMessage(NgoMessageEntity sendNgoMessageEntity) async {
    emit(SendNgoMessageLoading());
    var result = await messageRepo.sendNgoMessage(sendNgoMessageEntity);
    result.fold((f) {
      emit(
        SendNgoMessageFailure(f.message),
      );
    }, (r) {
      emit(SendNgoMessageSuccess());
    });
  }
}
