import 'package:flutter/material.dart';
import 'package:todo/common/app_dialogs.dart';
import 'package:todo/common/task_text_field.dart';

import '../../../../common/date_time_text_field.dart';

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
    return Padding(
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
            Row(
              children: [
                Expanded(
                  child: DateTimeTextField(
                    title: 'task date',
                    hint:
                        selectedDate == null
                            ? 'choose date'
                            : '${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}',
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
                            : '${selectedTime!.hour}:${selectedTime!.minute}',
                    onPress: () {
                      showTimePickerDialog();
                    },
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                addTask();
              },
              child: Text('add task'),
            ),
          ],
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

  void addTask() {
    if (formKey.currentState!.validate() == false) return;
    if (selectedDate == null) {
      showMessageDialog(
        context: context,
        message: 'please choose task date',
        posButtonText: 'ok',
      );
      return;
    }
    if (selectedTime == null) {
      showMessageDialog(
        context: context,
        message: 'please choose task time',
        posButtonText: 'ok',
      );
      return;
    }
  }
}
