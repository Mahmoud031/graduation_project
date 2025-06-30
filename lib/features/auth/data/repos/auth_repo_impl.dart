import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/errors/exceptions.dart';
import 'package:graduation_project/core/errors/failures.dart';
import 'package:graduation_project/core/services/database_service.dart';
import 'package:graduation_project/core/services/firebase_auth_service.dart';
import 'package:graduation_project/core/services/shared_preferences_singleton.dart';
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
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailandPassword(
          email: email, password: password);
      var userEntity = UserEntity(
          name: name,
          email: email,
          age: age,
          phone: phone,
          nationalId: nationalId,
          address: address,
          type: type,
          uId: user.uid);
      await adduserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
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
    User? user;
    try {
      user = await firebaseAuthService.createUserWithEmailandPassword(
          email: email, password: password);
      var ngoEntity = NgoEntity(
          name: name,
          email: email,
          phone: phone,
          ngoId: ngoId,
          address: address,
          uId: user.uid);
      await addNgoData(ngo: ngoEntity);
      return right(ngoEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(e.message));
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthService.deleteUser();
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailandPassword(
          email: email, password: password);
      var userEntity = await getUserData(uId: user.uid);
      await saveUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithEmailAndPassword: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, NgoEntity>> signInWithEmailAndPasswordNgo(
      String email, String password) async {
    try {
      var user = await firebaseAuthService.signInWithEmailandPassword(
          email: email, password: password);
      var ngoEntity = await getNgoData(uId: user.uid);
      await saveNgoData(ngo: ngoEntity);
      return right(ngoEntity);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.signInWithEmailAndPasswordNgo: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, Object>> signInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      try {
        // Try to get existing user data
        var userEntity = await getUserData(uId: user.uid);
        // If we get here, the user exists and has a complete profile
        await saveUserData(user: userEntity);
        return right(userEntity);
      } on CustomException catch (e) {
        if (e.message == 'Some requested document was not found.') {
          // If User data not found, try to get existing NGO data
          try {
            var ngoEntity = await getNgoData(uId: user.uid);
            await saveNgoData(ngo: ngoEntity);
            return right(ngoEntity);
          } on CustomException catch (e) {
            if (e.message == 'Some requested document was not found.') {
              // Neither User nor NGO data found, return basic user entity
              var basicUserEntity = UserModel.fromFirebaseUser(user);
              return right(basicUserEntity);
            } else {
              rethrow; // Re-throw other CustomExceptions from getNgoData
            }
          }
        } else {
          rethrow; // Re-throw other CustomExceptions from getUserData
        }
      }
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> completeGoogleSignInProfile({
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
    try {
      if (isMember) {
        UserEntity userEntity = UserEntity(
          uId: uId,
          email: email,
          name: name,
          address: address,
          type: type,
          age: age,
          nationalId: nationalId,
          phone: phone,
        );
        try {
          await getUserData(uId: uId); // Check if document exists
          await updateUserData(user: userEntity);
        } on CustomException catch (e) {
          if (e.message == 'Some requested document was not found.') {
            await adduserData(user: userEntity);
          } else {
            rethrow; // Re-throw if it's another CustomException
          }
        }
        await saveUserData(user: userEntity);
        return right(userEntity);
      } else {
        NgoEntity ngoEntity = NgoEntity(
          uId: uId,
          email: email,
          name: name,
          address: address,
          phone: phone,
          ngoId: nationalId, // Using nationalId as ngoId
        );
        try {
          await getNgoData(uId: uId); // Check if document exists
          await updateNgoData(ngo: ngoEntity);
        } on CustomException catch (e) {
          if (e.message == 'Some requested document was not found.') {
            await addNgoData(ngo: ngoEntity);
          } else {
            rethrow; // Re-throw if it's another CustomException
          }
        }
        await saveNgoData(ngo: ngoEntity);
        return right(UserEntity(
          uId: uId,
          email: email,
          name: name,
          address: address,
          type: 'NGO',
          age: 0,
          nationalId: nationalId,
          phone: phone,
        ));
      }
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.completeGoogleSignInProfile: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }


  @override
  Future<void> adduserData({required UserEntity user}) async {
    try {
      log('Adding user data: ${UserModel.fromEntity(user).toMap()}');
      await databaseService.addData(
          path: BackendEndpoint.addUserData,
          data: UserModel.fromEntity(user).toMap(),
          documentId: user.uId);
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> addNgoData({required NgoEntity ngo}) async {
    try {
      log('Adding NGO data: ${NgoModel.fromEntity(ngo).toMap()}');
      await databaseService.addData(
          path: BackendEndpoint.addNgoData,
          data: NgoModel.fromEntity(ngo).toMap(),
          documentId: ngo.uId);
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<NgoEntity> getNgoData({required String uId}) async {
    var ngoData = await databaseService.getData(
        path: BackendEndpoint.getNgoData, documentId: uId);
    if (ngoData == null) {
      throw CustomException(message: 'Some requested document was not found.');
    }
    return NgoModel.fromJson(ngoData);
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var userData = await databaseService.getData(
        path: BackendEndpoint.getUserData, documentId: uId);
    if (userData == null) {
      throw CustomException(message: 'Some requested document was not found.');
    }
    return UserModel.fromJson(userData);
  }

  @override
  Future<Either<Failure, NgoEntity>> ngoSignInWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthService.signInWithGoogle();
      var ngoEntity = NgoModel.fromFirebaseUser(user);
      await addNgoData(ngo: ngoEntity);
      return right(ngoEntity);
    } catch (e) {
      await deleteUser(user);
      log('Exception in AuthRepoImpl.signInWithGoogle: ${e.toString()}');
      return left(
          ServerFailure('An unknown error occurred. please try later.'));
    }
  }

  @override
  Future saveNgoData({required NgoEntity ngo}) {
    var jsonData = jsonEncode(NgoModel.fromEntity(ngo).toMap());
    return Prefs.setString(kNgoData, jsonData);
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    var jsonData = jsonEncode(UserModel.fromEntity(user).toMap());
    await Prefs.setString(kUserData, jsonData);
  }

  @override
  Future<void> updateUserData({required UserEntity user}) async {
    try {
      log('Updating user data: ${UserModel.fromEntity(user).toMap()}');
      await databaseService.updateData(
          path: BackendEndpoint.addUserData,
          data: UserModel.fromEntity(user).toMap(),
          documentId: user.uId);
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> updateNgoData({required NgoEntity ngo}) async {
    try {
      log('Updating NGO data: ${NgoModel.fromEntity(ngo).toMap()}');
      await databaseService.updateData(
          path: BackendEndpoint.addNgoData,
          data: NgoModel.fromEntity(ngo).toMap(),
          documentId: ngo.uId);
    } on CustomException catch (e) {
      throw CustomException(message: e.message);
    } catch (e) {
      throw CustomException(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuthService.signOut();
    await Prefs.setString(kUserData, '');
    await Prefs.setString(kNgoData, '');
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await firebaseAuthService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.changePassword: ${e.toString()}');
      return left(ServerFailure('An unknown error occurred. Please try again later.'));
    }
  }
  
  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.resetPassword: \\${e.toString()}');
      return left(ServerFailure('An unknown error occurred. Please try again later.'));
    }
  }
  
  @override
  Future<Either<Failure, void>> resetPasswordNgo(String email) async {
    try {
      await firebaseAuthService.sendPasswordResetEmail(email);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      log('Exception in AuthRepoImpl.resetPasswordNgo: \\${e.toString()}');
      return left(ServerFailure('An unknown error occurred. Please try again later.'));
    }
  }
}
