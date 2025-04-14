import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/tabs/todo_list_tab/task_item.dart';

import '../../providers/app_auth_provider.dart';

class TodoListTab extends StatefulWidget {
  static String tabTitle = 'To Do List';

  const TodoListTab({super.key});

  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  @override
  Widget build(BuildContext context) {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    if (authProvider.user != null) {
      setState(() {
        TodoListTab.tabTitle = 'welcome ${authProvider.user!.userName!}';
      });
    }
    ;
    return Container(
      margin: EdgeInsets.all(20),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return TaskItem();
        },
        itemCount: 10,
      ),
    );
  }
}
