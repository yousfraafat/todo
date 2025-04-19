import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/collections/users_collection.dart';
import 'package:todo/database/models/app_user.dart';

class AppAuthProvider extends ChangeNotifier {
  UsersCollection usersCollection = UsersCollection();
  User? currentUser;
  AppUser? user;
  String tabTitle = 'To Do List';

  AppAuthProvider() {
    currentUser = FirebaseAuth.instance.currentUser;
    getCurrentUser();
  }

  Future<void> getTabTitle() async {
    if (user != null) {
      tabTitle = 'welcome: ${user!.userName!}';
    }
    notifyListeners();
    return;
  }

  Future<void> getCurrentUser() async {
    if (isLoggedIn()) {
      await signInWithUid(currentUser!.uid);
      await getTabTitle();
      notifyListeners();
    }
  }

  bool isLoggedIn() {
    return currentUser != null;
  }

  Future<void> login(User newUser, String uid) async {
    currentUser = newUser;
    await signInWithUid(uid);
  }

  void logout() {
    currentUser = null;
    FirebaseAuth.instance.signOut();
  }

  Future<AppUser?> createUserWithEmailAndPassword(
    String email,
    String password,
      String userName
  ) async {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    if (credential.user != null) {
      user = AppUser(
          authId: credential.user?.uid, email: email, userName: userName);
      await usersCollection.addUser(user!);
    }
    return user;
  }

  Future<AppUser?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (credential.user != null) {
      login(credential.user!, credential.user!.uid);
    }
    return user;
  }

  Future<void> signInWithUid(String uid) async {
    user = await usersCollection.getUser(uid);
    await getTabTitle();
    notifyListeners();
  }
}
