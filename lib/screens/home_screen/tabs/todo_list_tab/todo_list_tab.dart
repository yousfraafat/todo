import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/database/models/task.dart';
import 'package:todo/date_time_utils.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/screens/home_screen/tabs/todo_list_tab/task_item.dart';

import '../../../../providers/tasks_provider.dart';

class TodoListTab extends StatefulWidget {
  static const String tabTitle = 'To Do List';

  const TodoListTab({super.key});

  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  List<Task>? tasks;
  late AppAuthProvider authProvider;
  String? uid;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    authProvider.getCurrentUser();
    uid = authProvider.user?.authId;
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Column(
      children: [
        EasyDateTimeLine(
          dayProps: EasyDayProps(
            todayHighlightStyle: TodayHighlightStyle.withBorder,
            todayHighlightColor: MyTheme.lightPrimary,
            todayStyle: DayStyle(
              decoration: BoxDecoration(
                border: Border.all(color: MyTheme.lightPrimary, width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            inactiveDayStyle: DayStyle(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          activeColor: MyTheme.lightPrimary,
          initialDate: DateTime.now(),
          onDateChange: (date) {
            setState(() {
              selectedDate = date;
            });
          },
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot<Task>>(
            stream: tasksProvider.tasksCollection.listenForTasks(
              uid,
              selectedDate.dateOnly(),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: MyTheme.lightPrimary),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 20, color: MyTheme.lightPrimary),
                  ),
                );
              }
              if (snapshot.hasData) {
                tasks = snapshot.data?.docs.map((doc) => doc.data()).toList();
                return Container(
                  margin: EdgeInsets.all(20),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return TaskItem(task: tasks![index]);
                    },
                    itemCount: tasks!.length,
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    'no tasks to show',
                    style: TextStyle(fontSize: 20, color: MyTheme.lightPrimary),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
