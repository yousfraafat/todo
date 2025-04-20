import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_dialogs.dart';
import 'package:todo/database/models/task.dart';
import 'package:todo/date_time_utils.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/screens/task_details_screen.dart';

import '../../../../my_theme.dart';
import '../../../../providers/tasks_provider.dart';

class TaskItem extends StatefulWidget {
  Task task;

  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Slidable(
        startActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (BuildContext) {
                showMessageDialog(
                  context: context,
                  message: 'do you want to delete this task ?',
                  posButtonText: 'yes',
                  posButtonTap: () {
                    tasksProvider.removeTask(
                      widget.task,
                      authProvider.user!.authId,
                    );
                    popDialog(context);
                  },
                  negButtonText: 'no',
                  negButtonTap: () {
                    popDialog(context);
                  },
                );
                return;
              },
              autoClose: true,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'delete',
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
          ],
        ),
        child: InkWell(
          onTap:
              () => Navigator.pushNamed(context, TaskDetailsScreen.routeName),
          child: Card(
            elevation: 5,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color:
                          widget.task.isDone == false
                              ? MyTheme.lightPrimary
                              : Color(0xff61E757),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 45),
                    margin: EdgeInsets.only(right: 30),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.task.title}',
                        style: TextStyle(
                          color:
                              widget.task.isDone == false
                                  ? MyTheme.lightPrimary
                                  : Color(0xff61E757),
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined),
                          SizedBox(width: 5),
                          Text(
                            '${widget.task.time?.formatTime()}',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  widget.task.isDone == false
                      ? InkWell(
                        onTap: () {
                          showLoadingDialog(
                            context: context,
                            message: 'please wait...',
                          );
                          tasksProvider.isDoneTask(
                            widget.task,
                            authProvider.user?.authId,
                            true,
                          );
                          popDialog(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MyTheme.lightPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ImageIcon(
                            AssetImage('assets/images/icon_check.png'),
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      )
                      : InkWell(
                        onTap: () {
                          showLoadingDialog(
                            context: context,
                            message: 'please wait...',
                          );
                          tasksProvider.isDoneTask(
                            widget.task,
                            authProvider.user?.authId,
                            false,
                          );
                          popDialog(context);
                        },
                        child: Text(
                          'Done!',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff61E757),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
