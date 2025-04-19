import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String nationalId,
    required String address,
  required String type,
    required int age,
  }) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
        email, password, name, phone, nationalId, address, type, age);
    result.fold(
      (failure) {
        emit(SignupFailure(message: failure.message));
      },
      (userEntity) {
        emit(SignupSuccess(userEntity: userEntity));
      },
    );
  }
}
