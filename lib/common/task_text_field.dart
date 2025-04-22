import 'package:flutter/material.dart';

import 'my_text_field.dart';

typedef OnChanged = void Function(String)?;

class TaskTextField extends StatelessWidget {
  String title;
  String hint;
  int lines;
  Validator? validator;
  TextEditingController? controller;
  OnChanged? onChanged;


  TaskTextField({
    super.key,
    required this.title,
    required this.hint,
    this.lines = 1,
    this.controller,
    this.validator,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.black, fontSize: 20)),
          TextFormField(
            minLines: 1,
            maxLines: lines,
            validator: validator,
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 20),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(fontSize: 20),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
            controller: controller,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
