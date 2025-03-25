import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppAuthProvider extends ChangeNotifier {
  User? currentUser;

  AppAuthProvider() {
    currentUser = FirebaseAuth.instance.currentUser;
  }

  bool isLoggedIn() {
    return currentUser != null;
  }

  void login(User newUser) {
    currentUser = newUser;
  }

  void logout() {
    currentUser = null;
    FirebaseAuth.instance.signOut();
  }

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      login(credential.user!);
    }
    return credential;
  }
}
