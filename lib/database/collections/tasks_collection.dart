import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/database/models/task.dart';

class TasksCollection {
  CollectionReference<Task> getTasksCollection(uid) {
    var db = FirebaseFirestore.instance;
    return db
        .collection('users')
        .doc(uid)
        .collection('tasks')
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Task.fromFireStore(snapshot.data());
          },
          toFirestore: (task, options) {
            return task.toFireStore();
          },
        );
  }

  Future<void> createTask(Task task, String? uid) async {
    var docRef = getTasksCollection(uid).doc();
    task.id = docRef.id;
    docRef.set(task);
  }

  Future<void> deleteTask(Task task, String? uid) async {
    return await getTasksCollection(uid).doc(task.id).delete();
  }

  Future<List<Task>> getTasksList(uid) async {
    var snapshot = await getTasksCollection(uid).get();
    var tasksList = snapshot.docs.map((e) => e.data()).toList();
    return tasksList;
  }
}
