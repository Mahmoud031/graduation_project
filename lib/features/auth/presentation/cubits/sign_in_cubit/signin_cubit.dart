import 'package:bloc/bloc.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';
import 'dart:developer';
import '../../../domain/entities/ngo_entity.dart';
part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;
  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    emit(SigninLoading());
    
    final ngoResult = await authRepo.signInWithEmailAndPasswordNgo(email, password);
    
    if (ngoResult.isRight()) {
      
      ngoResult.fold(
        (failure) => null, 
        (ngoEntity) => emit(SigninSuccess(ngoEntity)),
      );
    } else {
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
      (entity) {
        bool needsProfileCompletion = false;

        log('SigninCubit: Entity Type: ${entity.runtimeType}');
        if (entity is NgoEntity) {
          log('NGO Entity Fields: address=${entity.address}, phone=${entity.phone}, ngoId=${entity.ngoId}');
          // For NGOs, check if essential NGO fields are filled (name, address, phone, ngoId)
          if (entity.address.isEmpty ||
              entity.phone.isEmpty ||
              entity.ngoId.isEmpty) {
            needsProfileCompletion = true;
          }
        } else if (entity is UserEntity) {
          log('User Entity Fields: address=${entity.address}, phone=${entity.phone}, nationalId=${entity.nationalId}, age=${entity.age}');
          // For Members/Donors, check if essential User fields are filled
          if (entity.address.isEmpty ||
              entity.phone.isEmpty ||
              entity.nationalId.isEmpty ||
              entity.age == 0) { // Check age for donor
            needsProfileCompletion = true;
          }
        } else {
          // This case should ideally not be reached if AuthRepo returns only UserEntity or NgoEntity
          needsProfileCompletion = true; // Assume profile needs completion if type is unknown
        }
        log('SigninCubit: Needs Profile Completion: $needsProfileCompletion');

        emit(SigninSuccess(
          entity,
          isGoogleSignIn: needsProfileCompletion,
        ));
      },
    );
  }
}
