import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';

part 'donor_profile_edit_state.dart';

class DonorProfileEditCubit extends Cubit<DonorProfileEditState> {
  final AuthRepo authRepo;

  DonorProfileEditCubit(this.authRepo) : super(DonorProfileEditInitial());

  Future<void> updateDonorProfile(UserEntity updatedUser) async {
    emit(DonorProfileEditLoading());
    try {
      await authRepo.updateUserData(user: updatedUser);
      emit(DonorProfileEditSuccess(updatedUser));
    } catch (e) {
      emit(DonorProfileEditFailure(e.toString()));
    }
  }
} 