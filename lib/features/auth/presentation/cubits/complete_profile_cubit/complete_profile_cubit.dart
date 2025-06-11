import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';

part 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit(this.authRepo) : super(CompleteProfileInitial());
  final AuthRepo authRepo;

  Future<void> completeProfile({
    required String uId,
    required String email,
    required String name,
    required String address,
    required String type,
    required int age,
    required String nationalId,
    required String phone,
    required bool isMember,
  }) async {
    emit(CompleteProfileLoading());
    final result = await authRepo.completeGoogleSignInProfile(
      uId: uId,
      email: email,
      name: name,
      address: address,
      type: type,
      age: age,
      nationalId: nationalId,
      phone: phone,
      isMember: isMember,
    );
    result.fold(
      (failure) => emit(CompleteProfileFailure(message: failure.message)),
      (userEntity) => emit(CompleteProfileSuccess(userEntity)),
    );
  }
}
