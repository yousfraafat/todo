import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_dialogs.dart';
import 'package:todo/database/models/task.dart';
import 'package:todo/date_time_utils.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/providers/tasks_provider.dart';

import '../common/date_time_text_field.dart';
import '../common/task_text_field.dart';

class TaskDetailsScreen extends StatefulWidget {
  static const String routeName = 'task details screen';

  TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEditing = false;
  late Task task;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs is Task) {
      task = routeArgs;
      titleController.text = task.title ?? '';
      descriptionController.text = task.description ?? '';
      dateController.text = task.date?.formatDate() ?? '';
      timeController.text = task.time?.formatTime() ?? '';
      selectedDate =
          task.date != null
              ? DateTime.fromMillisecondsSinceEpoch(task.date!)
              : null;
      selectedTime =
          task.time != null
              ? TimeOfDay.fromDateTime(
                DateTime.fromMillisecondsSinceEpoch(task.time!),
              )
              : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    print(titleController.text);
    print(descriptionController.text);
    print(dateController.text);
    print(titleController.text);
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: isEditing == false ? 'delete button' : 'cancel button',
            onPressed:
                isEditing == false
                    ? () {
                      deletePress(context, tasksProvider, authProvider);
                    }
                    : () {
                      setState(() {
                        isEditing = false;
                        titleController.text = task.title ?? '';
                        descriptionController.text = task.description ?? '';
                        dateController.text = task.date?.formatDate() ?? '';
                        timeController.text = task.time?.formatTime() ?? '';
                      });
                    },
            child: Icon(
              isEditing == false ? Icons.delete : Icons.close,
              color: Colors.white,
            ),
            shape: CircleBorder(),
            backgroundColor: Colors.red,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: isEditing == false ? 'edit button' : 'confirm button',
            onPressed:
                isEditing == false
                    ? () {
                      setState(() {
                        isEditing = true;
                        print('${titleController.text}');
                      });
                    }
                    : () async {
                      confirmPress(context, tasksProvider, authProvider);
                    },
            child: Icon(
              isEditing == false ? Icons.edit : Icons.check,
              color: Colors.white,
            ),
            shape: CircleBorder(),
          ),
        ],
      ),
      backgroundColor: MyTheme.lightSecondary,
      appBar: AppBar(
        title: Text('Task Details'),
        backgroundColor: Color(0xff5D9CEC),
      ),
      body: Card(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        color: Colors.white,
        child: Container(
          margin: EdgeInsets.all(30),
          child:
              isEditing == false
                  ? buildTaskDetailsForm()
                  : buildTaskEditingForm(),
        ),
      ),
    );
  }

  Widget buildTaskDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text('${task.title}', style: TextStyle(fontSize: 30))),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(color: Colors.black, thickness: 2),
        ),
        Expanded(
          child: Text('${task.description}', style: TextStyle(fontSize: 25)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(color: Colors.black, thickness: 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${task.date?.formatDate()}', style: TextStyle(fontSize: 25)),
            Text('${task.time?.formatTime()}', style: TextStyle(fontSize: 25)),
          ],
        ),
      ],
    );
  }

  Widget buildTaskEditingForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TaskTextField(
            controller: titleController,
            title: 'task title',
            hint: 'new task title',
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return 'please enter task title';
              }
              return null;
            },
          ),
          TaskTextField(
            controller: descriptionController,
            title: 'task description',
            hint: 'new task description',
            lines: 20,
            validator: (text) {
              if (text == null || text.trim().isEmpty) {
                return 'please enter task description';
              }
              return null;
            },
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: DateTimeTextField(
                    controller: dateController,
                    title: 'task date',
                    hint:
                        selectedDate == null
                            ? dateController.text
                            : '${selectedDate?.formatDate()}',
                    onPress: () {
                      showDatePickerDialog();
                    },
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: DateTimeTextField(
                    controller: timeController,
                    title: 'task time',
                    hint:
                        selectedTime == null
                            ? timeController.text
                            : '${selectedTime?.formatTime()}',
                    onPress: () {
                      showTimePickerDialog();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> confirmPress(
    BuildContext context,
    TasksProvider tasksProvider,
    AppAuthProvider authProvider,
  ) async {
    showMessageDialog(
      context: context,
      message: 'do you want to save changes ?',
      posButtonText: 'yes',
      posButtonTap: () async {
        showLoadingDialog(context: context, message: 'please wait ...');
        Task updatedTask = Task.fromFireStore(task.toFireStore());
        if (selectedDate != null) {
          updatedTask.date = selectedDate?.dateOnly();
        }
        if (selectedTime != null) {
          updatedTask.time = selectedTime?.epochTime();
        }
        await tasksProvider.updateTask(task, authProvider.user?.authId, {
          'title': titleController.text,
          'description': descriptionController.text,
          'date': updatedTask.date,
          'time': updatedTask.time,
        });
        popDialog(context);
        print('Updated Task: ${updatedTask}');
        setState(() {
          task = updatedTask;
          isEditing = false;
          selectedDate = null;
          selectedTime = null;
        });
        print('Task after setState: ${task}');
        Navigator.pop(context);
      },
      negButtonText: 'no',
      negButtonTap: () => popDialog(context),
    );
  }

  void deletePress(
    BuildContext context,
    TasksProvider tasksProvider,
    AppAuthProvider authProvider,
  ) {
    showMessageDialog(
      context: context,
      message: 'do you want to delete this task ?',
      posButtonText: 'yes',
      posButtonTap: () {
        Navigator.pop(context);
        tasksProvider.removeTask(task, authProvider.user!.authId);
        popDialog(context);
      },
      negButtonText: 'no',
      negButtonTap: () {
        popDialog(context);
      },
    );
  }

  Future<void> showDatePickerDialog() async {
    var newDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      cancelText: 'cancel',
      confirmText: 'ok',
    );
    if (newDate == null) return;
    setState(() {
      selectedDate = newDate;
      dateController.text = newDate.formatDate();
    });
  }

  Future<void> showTimePickerDialog() async {
    var newTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (newTime == null) return;
    setState(() {
      selectedTime = newTime;
      timeController.text = newTime.formatTime();
    });
  }
}
