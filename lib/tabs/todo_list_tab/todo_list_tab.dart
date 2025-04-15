import 'package:flutter/material.dart';
import 'package:todo/tabs/todo_list_tab/task_item.dart';

class TodoListTab extends StatefulWidget {
  static const String tabTitle = 'To Do List';

  const TodoListTab({super.key});

  @override
  State<TodoListTab> createState() => _TodoListTabState();
}

class _TodoListTabState extends State<TodoListTab> {
  @override
  Widget build(BuildContext context) {
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
