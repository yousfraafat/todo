import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_dialogs.dart';
import 'package:todo/common/task_text_field.dart';
import 'package:todo/date_time_utils.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/providers/tasks_provider.dart';

import '../../../../common/date_time_text_field.dart';
import '../../../../database/models/task.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Add new Task',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TaskTextField(
                controller: title,
                title: 'task title',
                hint: 'enter task title',
                validator: (text) {
                  if (text == null || text.trim().isEmpty) {
                    return 'please enter task title';
                  }
                  return null;
                },
              ),
              TaskTextField(
                controller: description,
                title: 'task description',
                hint: 'enter task description',
                lines: 3,
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
                        title: 'task date',
                        hint:
                            selectedDate == null
                                ? 'choose date'
                                : '${selectedDate?.formatDate()}',
                        onPress: () {
                          showDatePickerDialog();
                        },
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: DateTimeTextField(
                        title: 'task time',
                        hint:
                            selectedTime == null
                                ? 'choose time'
                                : '${selectedTime?.formatTime()}',
                        onPress: () {
                          showTimePickerDialog();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
                onPressed: () {
                  addTask();
                },
                child: Text('add task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate;

  Future<void> showDatePickerDialog() async {
    var date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      cancelText: 'cancel',
      confirmText: 'ok',
    );
    if (date == null) return;
    setState(() {
      selectedDate = date;
    });
  }

  TimeOfDay? selectedTime;

  Future<void> showTimePickerDialog() async {
    var time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time == null) return;
    setState(() {
      selectedTime = time;
    });
  }

  Future<void> addTask() async {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(
      context,
      listen: false,
    );
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    if (isValidTask()) {
      var task = Task(
        description: description.text,
        title: title.text,
        time: selectedTime?.epochTime(),
        date: selectedDate?.dateOnly(),
      );
      try {
        showLoadingDialog(context: context, message: 'adding task ...');
        await tasksProvider.addTask(task, authProvider.user!.authId);
        popDialog(context);
        showMessageDialog(
          context: context,
          message: 'add task successfully',
          posButtonText: 'ok',
          posButtonTap: () {
            popDialog(context);
            setState(() {
              Navigator.pop(context);
            });
          },
        );
      } catch (e) {
        popDialog(context);
        showMessageDialog(
          context: context,
          message: 'something went wrong ',
          posButtonText: 'ok',
        );
      }
    }
  }

  bool isValidTask() {
    bool isValid = true;
    if (formKey.currentState!.validate() == false) {
      isValid = false;
    }
    if (selectedDate == null) {
      showMessageDialog(
        context: context,
        message: 'please choose task date',
        posButtonText: 'ok',
      );
      isValid = false;
    }
    if (selectedTime == null) {
      showMessageDialog(
        context: context,
        message: 'please choose task time',
        posButtonText: 'ok',
      );
      isValid = false;
    }
    return isValid;
  }
}
