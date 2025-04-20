import 'package:flutter/material.dart';
import 'package:todo/database/collections/tasks_collection.dart';
import 'package:todo/database/models/task.dart';
import 'package:todo/date_time_utils.dart';

class TasksProvider extends ChangeNotifier {
  TasksCollection tasksCollection = TasksCollection();

  Future<void> addTask(Task task, String? uid) async {
    await tasksCollection.createTask(task, uid);
    notifyListeners();
    return;
  }

  Future<void> removeTask(Task task, String? uid) async {
    await tasksCollection.deleteTask(task, uid);
    notifyListeners();
    return;
  }

  Future<void> isDoneTask(Task task, String? uid, bool newValue) async {
    await tasksCollection.updateTask(task, uid, {'isDone': newValue});
    notifyListeners();
    return;
  }

  Future<List<Task>> getAllTasks(String? uid, DateTime selectedDate) async {
    List<Task> tasks = await tasksCollection.getTasksList(
      uid,
      selectedDate.dateOnly(),
    );
    return tasks;
  }
}
