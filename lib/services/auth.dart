import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomUser {
  final String uid;

  CustomUser({required this.uid});
}

abstract class AuthBase {
  Future<CustomUser?> googleSignIn();

  Stream<CustomUser?> get onAuthStateChanged;

  Future<CustomUser?> currentUser();

  Future<CustomUser?> signInAnonymously();

  Future<CustomUser?> signInWithEmailAndPassword(String email, String password);

  Future<CustomUser?> createUserWithEmailAndPassword(
      String email, String password);

  Future<void> signOut();
}

class Auth implements AuthBase {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> _initializeFirebaseApp() async {
    try {
      // Firebase.initializeApp().whenComplete(() async {
      //   user = _firebaseAuth.currentUser;
      // });
      await Firebase.initializeApp();
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print("Error init FirebaseApp $err");
    }
  }

  CustomUser? _userFromFirebase(User? user) {
    print('_userFromFirebase(User? user)');
    if (user == null) {
      return null;
    }
    return CustomUser(uid: user.uid);
  }

  @override
  Stream<CustomUser?> get onAuthStateChanged {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<CustomUser?> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleAccount = await googleSignIn.signIn();
      if (googleAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleAccount.authentication;
        if (googleAuth.accessToken != null && googleAuth.idToken != null) {
          final UserCredential authResult = await _firebaseAuth
              .signInWithCredential(GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ));
          return _userFromFirebase(authResult.user);
        } else {
          throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing GoogleAuth Token',
          );
        }
      } else {
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      print(error);
    }
  }

  @override
  Future<CustomUser?> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential authResult =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<CustomUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    final UserCredential authResult =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<CustomUser?> currentUser() async {
    print("currentUser()");
    User? user;
    try {
      // Firebase.initializeApp().whenComplete(() async {
      //   user = _firebaseAuth.currentUser;
      // });
      await Firebase.initializeApp();
      user = FirebaseAuth.instance.currentUser;
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print("currentUser() $err");
    }
    return _userFromFirebase(user);
  }

  @override
  Future<CustomUser?> signInAnonymously() async {
    print('signInAnonymously()');
    UserCredential? authResult;
    try {
      // Firebase.initializeApp().whenComplete(() async {
      //   UserCredential authResult = await _firebaseAuth.signInAnonymously();
      // });
      await Firebase.initializeApp();
      authResult = await FirebaseAuth.instance.signInAnonymously();
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print('signInAnonymously(): $err');
    }
    return _userFromFirebase(authResult?.user);
  }

  @override
  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    print('signOut()');
    try {
      // Firebase.initializeApp().whenComplete(() async {
      //   await _firebaseAuth.signOut();
      // });

      await FirebaseAuth.instance.signOut();
      // ignore: avoid_catches_without_on_clauses
    } catch (err) {
      print('signOut(): $err');
    }
  }
}
