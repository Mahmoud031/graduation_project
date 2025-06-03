import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.authRepo) : super(LogoutInitial());
  final AuthRepo authRepo;

  Future<void> signOut() async {
    emit(LogoutLoading());
    try {
      await authRepo.signOut();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutFailure(message: e.toString()));
    }
  }
} 