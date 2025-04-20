import 'package:flutter/material.dart';

class TaskDetailsScreen extends StatelessWidget {
  static const String routeName = 'task details screen';

  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Color(0xff5D9CEC),
      ),
    );
  }
}
