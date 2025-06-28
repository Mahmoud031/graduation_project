import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.authRepo) : super(ForgotPasswordInitial());
  final AuthRepo authRepo;

  Future<void> resetPassword(String email, {bool isNgo = false}) async {
    emit(ForgotPasswordLoading());
    final result = isNgo
        ? await authRepo.resetPasswordNgo(email)
        : await authRepo.resetPassword(email);
    result.fold(
      (failure) => emit(ForgotPasswordFailure(message: failure.message)),
      (_) => emit(ForgotPasswordSuccess()),
    );
  }
} 