import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/failures.dart';
import '../entities/ngo_entity.dart';
import '../entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email,
      String password,
      String name,
      String phone,
      String nationalId,
      String address,
      String type,
      int age);

  Future<Either<Failure, NgoEntity>> createNgoWithEmailAndPassword(String email,
      String password, String name, String phone, String ngoId, String address);
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, NgoEntity>> signInWithEmailAndPasswordNgo(
      String email, String password);
  Future<Either<Failure, UserEntity>> signInWithGoogle();
  Future<Either<Failure, NgoEntity>> ngoSignInWithGoogle();

  Future<Either<Failure, UserEntity>> signInWithFacebook();
  Future<Either<Failure, NgoEntity>> ngoSignInFacebook();
  Future adduserData({required UserEntity user});
  Future addNgoData({required NgoEntity ngo});
  Future <UserEntity> getUserData({required String uId});
  Future <NgoEntity> getNgoData({required String uId});
  Future saveUserData({required UserEntity user});
  Future saveNgoData({required NgoEntity ngo});
  Future updateNgoData({required NgoEntity ngo});
  Future updateUserData({required UserEntity user});
}
