import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'ngo_signup_state.dart';

class NgoSignupCubit extends Cubit<NgoSignupState> {
  NgoSignupCubit(this.authRepo) : super(NgoSignupInitial());
  final AuthRepo authRepo;

  Future<void> createNgoWithEmailAndPassword(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String ngoId,
      required String address}) async {
    emit(NgoSignupLoading());
    final result = await authRepo.createNgoWithEmailAndPassword(
        email, password, name, phone, ngoId, address);
    result.fold(
      (failure) {
        emit(NgoSignupFailure(message: failure.message));
      },
      (ngoEntity) {
        emit(NgoSignupSuccess(ngoEntity: ngoEntity));
      },
    );
  }
}
