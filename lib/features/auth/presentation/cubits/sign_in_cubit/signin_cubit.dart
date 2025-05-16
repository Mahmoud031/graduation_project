import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;
  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    emit(SigninLoading());
    
    // Try donor sign-in first
    final donorResult = await authRepo.signInWithEmailAndPassword(email, password);
    
    if (donorResult.isRight()) {
      // If donor sign-in succeeds, emit success
      donorResult.fold(
        (failure) => null, // This won't be called since we checked isRight()
        (userEntity) => emit(SigninSuccess(userEntity)),
      );
    } else {
      // If donor sign-in fails, try NGO sign-in
      final ngoResult = await authRepo.signInWithEmailAndPasswordNgo(email, password);
      ngoResult.fold(
        (failure) => emit(SigninFailure(message: failure.message)),
        (ngoEntity) => emit(SigninSuccess(ngoEntity)),
      );
    }
  }
 
  Future<void> signInWithGoogle() async {
    emit(SigninLoading());
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }
  Future<void> signInWithFacebook() async {
    emit(SigninLoading());
    final result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(SigninFailure(message: failure.message)),
      (userEntity) => emit(SigninSuccess(userEntity)),
    );
  }
}
