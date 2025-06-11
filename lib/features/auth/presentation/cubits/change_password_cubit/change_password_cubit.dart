import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit(this.authRepo) : super(ChangePasswordInitial());
  final AuthRepo authRepo;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoading());
    final result = await authRepo.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    result.fold(
      (failure) => emit(ChangePasswordFailure(message: failure.message)),
      (_) => emit(ChangePasswordSuccess()),
    );
  }
} 