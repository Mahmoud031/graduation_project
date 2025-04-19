import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future<User> createUserWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailandPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'The account already exists for that email.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection');
      } else {
        throw CustomException(
            message: 'An unknown error occurred. please try later.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailandPassword: ${e.toString()}");
      throw CustomException(
          message: 'An unknown error occurred. please try later.');
    }
  }
   Future<User> signInWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailandPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(message: ' email or password  is incorrect.');
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'email or password  is incorrect.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection');
      } 
      else {
        throw CustomException(
            message: 'An unknown error occurred. please try later.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailandPassword: ${e.toString()}");
      throw CustomException(
          message: 'An unknown error occurred. please try later.');
    }
  }
}
