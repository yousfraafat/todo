import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/models/app_user.dart';

class UsersCollection {
  CollectionReference<AppUser> getUsersCollection() {
    var db = FirebaseFirestore.instance;
    return db
        .collection('users')
        .withConverter(
          fromFirestore: (snapshot, options) {
            return AppUser.fromFireStore(snapshot.data());
          },
          toFirestore: (obj, options) {
            return obj.toFireStore();
          },
        );
  }

  Future<void> addUser(AppUser user) async {
    getUsersCollection().doc(user.authId).set(user);
  }

  Future<AppUser?> getUser(String uid) async {
    var doc = getUsersCollection().doc(uid);
    var docSnapShot = await doc.get();
    return docSnapShot.data();
  }
}
