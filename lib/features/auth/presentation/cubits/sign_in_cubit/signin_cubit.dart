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
    
    // Try NGO sign-in first
    final ngoResult = await authRepo.signInWithEmailAndPasswordNgo(email, password);
    
    if (ngoResult.isRight()) {
      // If NGO sign-in succeeds, emit success with NGO entity
      ngoResult.fold(
        (failure) => null, // This won't be called since we checked isRight()
        (ngoEntity) => emit(SigninSuccess(ngoEntity)),
      );
    } else {
      // If NGO sign-in fails, try donor sign-in
      final donorResult = await authRepo.signInWithEmailAndPassword(email, password);
      donorResult.fold(
        (failure) => emit(SigninFailure(message: failure.message)),
        (userEntity) => emit(SigninSuccess(userEntity)),
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
