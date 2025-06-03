import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

part 'profile_edit_state.dart';

class ProfileEditCubit extends Cubit<ProfileEditState> {
  final AuthRepo authRepo;
  ProfileEditCubit(this.authRepo) : super(ProfileEditInitial());

  Future<void> updateNgoProfile(NgoEntity ngo) async {
    emit(ProfileEditLoading());
    try {
      await authRepo.updateNgoData(ngo: ngo);
      emit(ProfileEditSuccess(ngo));
    } catch (e) {
      emit(ProfileEditFailure(e.toString()));
    }
  }
} 