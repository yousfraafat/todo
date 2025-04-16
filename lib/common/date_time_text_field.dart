import 'package:flutter/material.dart';

import 'my_text_field.dart';

class DateTimeTextField extends StatefulWidget {
  String title;
  String hint;
  VoidCallback onPress;
  Validator? validator;
  TextEditingController? controller;

  DateTimeTextField({
    super.key,
    required this.onPress,
    required this.title,
    required this.hint,
    this.controller,
    this.validator,
  });

  @override
  State<DateTimeTextField> createState() => _DateTimeTextFieldState();
}

class _DateTimeTextFieldState extends State<DateTimeTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          TextFormField(
            readOnly: true,
            onTap: () {
              widget.onPress.call();
            },
            validator: widget.validator,
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 20),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: 20),
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
            ),
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
