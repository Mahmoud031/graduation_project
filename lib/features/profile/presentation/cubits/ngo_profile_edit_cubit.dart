import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

part 'ngo_profile_edit_state.dart';

class NgoProfileEditCubit extends Cubit<NgoProfileEditState> {
  final AuthRepo authRepo;
  NgoProfileEditCubit(this.authRepo) : super(NgoProfileEditInitial());

  Future<void> updateNgoProfile(NgoEntity ngo) async {
    emit(NgoProfileEditLoading());
    try {
      await authRepo.updateNgoData(ngo: ngo);
      emit(NgoProfileEditSuccess(ngo));
    } catch (e) {
      emit(NgoProfileEditFailure(e.toString()));
    }
  }
}
