import 'dart:ffi';

import 'package:enitproject/package/debug_console.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends GetxService {
  /// singleton pattern
  static AuthService get to => Get.find();

  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> signInWithEmailAndPassword() async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: "enzoescipy@gmail.com", password: "superuser");
  }

  Future<void> logInWithEmailAndPassword() async {
    await _firebaseAuth.signInWithEmailAndPassword(email: "enzoescipy@gmail.com", password: "superuser");
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
}
