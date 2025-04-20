import 'package:dartz/dartz.dart';
import 'package:graduation_project/core/errors/exceptions.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/firebase_auth_service.dart';
import 'package:graduation_project/core/utils/backend_endpoint.dart';
import 'package:graduation_project/features/auth/data/models/user_model.dart';
import 'package:graduation_project/features/auth/domain/entities/ngo_entity.dart';
import 'package:graduation_project/features/auth/domain/repos/auth_repo.dart';
import 'package:graduation_project/features/auth/domain/entities/user_entity.dart';
import 'dart:developer';

import '../models/ngo_model.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthService firebaseAuthService;
  final DatabaseService databaseService;

  AuthRepoImpl(
      {required this.databaseService, required this.firebaseAuthService});
  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
      String email,
      String password,
      String name,
      String phone,
      String nationalId,
      String address,
      String type,
      int age) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailandPassword(
          email: email, password: password);
      var userEntity = UserModel.fromFirebaseUser(user);
      await adduserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, NgoEntity>> createNgoWithEmailAndPassword(
      String email,
      String password,
      String name,
      String phone,
      String ngoId,
      String address) async {
    try {
      var user = await firebaseAuthService.createUserWithEmailandPassword(
          email: email, password: password);
      var ngoEntity = NgoModel.fromFirebaseUser(user);
      await addNgoData(ngo: ngoEntity);
      return right(ngoEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailandPassword(
          email: email, password: password);
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() async {
    try {
      var user = await firebaseAuthService.signInWithGoogle();
      return right(UserModel.fromFirebaseUser(user));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithFacebook() async {
    try {
      var user = await firebaseAuthService.signInWithFacebook();
      return right(UserModel.fromFirebaseUser(user));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithFacebook: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future addNgoData({required NgoEntity ngo}) async {
    await databaseService.addData(
        path: BackendEndpoint.addNgoData, data: ngo.toMap());
  }

  @override
  Future adduserData({required UserEntity user}) async {
    await databaseService.addData(
        path: BackendEndpoint.addUserData, data: user.toMap());
  }
}
