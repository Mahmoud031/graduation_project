import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/core/errors/exceptions.dart';

class FirebaseAuthService {
  Future deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }

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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailandPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        throw CustomException(
            message: 'The email or password is incorrect. Please try again.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection');
      } else {
        throw CustomException(
            message: 'An unknown error occurred. Please try later.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailandPassword: ${e.toString()}");
      throw CustomException(
          message: 'An unknown error occurred. please try later.');
    }
  }

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return (await FirebaseAuth.instance.signInWithCredential(credential)).user!;
  }

  Future<User> signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

    return (await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential))
        .user!;
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw CustomException(message: 'No user is currently signed in.');
      }

      // Reauthenticate user before changing password
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      // Change password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.changePassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'wrong-password') {
        throw CustomException(message: 'Current password is incorrect.');
      } else if (e.code == 'weak-password') {
        throw CustomException(message: 'The new password is too weak.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection');
      } else {
        throw CustomException(
            message: 'An unknown error occurred. Please try again later.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.changePassword: ${e.toString()}");
      throw CustomException(
          message: 'An unknown error occurred. Please try again later.');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.sendPasswordResetEmail: \\${e.toString()} and code is \\${e.code}");
      if (e.code == 'user-not-found') {
        throw CustomException(message: 'No user found for that email.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'The email address is invalid.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'No internet connection');
      } else {
        throw CustomException(message: 'An unknown error occurred. Please try again later.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.sendPasswordResetEmail: \\${e.toString()}");
      throw CustomException(message: 'An unknown error occurred. Please try again later.');
    }
  }
}
