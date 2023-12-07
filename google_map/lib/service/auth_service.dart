import 'dart:ffi';

import 'package:enitproject/package/debug_console.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginStatus {
  succes,
  invalidEmail, // id field is not the email format
  userDisabled,
  userNotFound, // pw or email is wrong
  unexpected, // err code not given but login failed
  other, // not handled err code
}

class AuthService extends GetxService {
  /// singleton pattern
  static AuthService get to => Get.find();

  final _firebaseAuth = FirebaseAuth.instance;

  // Future<void> signInWithEmailAndPassword({required String email, required String password}) async {
  //   await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  // }

  Future<LoginStatus> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        return LoginStatus.unexpected;
      } else {
        return LoginStatus.succes;
      }
    } on FirebaseAuthException catch (error) {
      final errCode = error.code;
      switch (errCode) {
        case "invalid-email":
          return LoginStatus.invalidEmail;
        case "user-disabled":
          return LoginStatus.userDisabled;
        case "user-not-found":
          return LoginStatus.userNotFound;
        case "wrong-password":
          return LoginStatus.userNotFound;
        default:
          debugConsole(errCode);
          return LoginStatus.other;
      }
    }
  }

  /// null if login by google has been failed or google login-ed user not found in
  /// our user list.
  Future<UserCredential?> logInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final account = await googleSignIn.signIn();

    if (account == null) {
      return Future.value(null);
    }

    final authentication = await account.authentication;
    final googleCredential = GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );

    final userCredential = _firebaseAuth.signInWithCredential(googleCredential);
    return userCredential;
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? getEmail() {
    return _firebaseAuth.currentUser?.email;
  }
}
