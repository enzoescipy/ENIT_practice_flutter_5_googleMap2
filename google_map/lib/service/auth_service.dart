import 'dart:ffi';

import 'package:enitproject/model/user_preference_model.dart';
import 'package:enitproject/package/debug_console.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginStatus {
  success,
  invalidEmail, // id field is not the email format
  userDisabled,
  userNotFound, // pw or email is wrong
  unexpected, // err code not given but login failed
  other, // not handled err code
}

enum JoinStatus {
  success,
  nullParam,
  alreadyExistsEmail,
  weakPassword,
  passwordRepeatWrong,
  other,
}

enum WithDrawStatus {
  success,
  noLoginRecent,
  other,
}

class AuthService extends GetxService {
  /// singleton pattern
  static AuthService get to => Get.find();

  final _firebaseAuth = FirebaseAuth.instance;

  Future<JoinStatus> joinWithEmailAndPassword(UserPrefModel userPrefModel, {required String passwordRepeat}) async {
    if (userPrefModel.email == null || userPrefModel.password == null) {
      return JoinStatus.nullParam;
    }
    if (passwordRepeat != userPrefModel.password) {
      return JoinStatus.passwordRepeatWrong;
    }
    try {
      debugConsole([userPrefModel.email, userPrefModel.password]);
      await _firebaseAuth.createUserWithEmailAndPassword(email: userPrefModel.email!, password: userPrefModel.password!);
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case 'weak-password':
          return JoinStatus.weakPassword;
        case 'email-already-in-use':
          return JoinStatus.alreadyExistsEmail;
        default:
          return JoinStatus.other;
      }
    }

    return JoinStatus.success;
  }

  Future<WithDrawStatus> withDrawUser() async {
    if (_firebaseAuth.currentUser == null) {
      return WithDrawStatus.noLoginRecent;
    }

    try {
      await _firebaseAuth.currentUser?.delete();
      return WithDrawStatus.success;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case ('requires-recent-login'):
          return WithDrawStatus.noLoginRecent;
        default:
          return WithDrawStatus.other;
      }
    }
  }

  Future<LoginStatus> logInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (credential.user == null) {
        return LoginStatus.unexpected;
      } else {
        return LoginStatus.success;
      }
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          return LoginStatus.invalidEmail;
        case "user-disabled":
          return LoginStatus.userDisabled;
        case "user-not-found":
          return LoginStatus.userNotFound;
        case "wrong-password":
          return LoginStatus.userNotFound;
        default:
          return LoginStatus.other;
      }
    }
  }

  /// null if login by google has been failed or google login-ed user not found in our user list.
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

    final userCredential = await _firebaseAuth.signInWithCredential(googleCredential);
    await googleSignIn.disconnect();
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
