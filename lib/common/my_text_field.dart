import 'package:flutter/material.dart';

typedef Validator = String? Function(String?)?;

class MyTextField extends StatefulWidget {
  String title;
  String hint;
  TextInputType inputType;
  bool securedPassword;
  Validator? validator;
  TextEditingController? controller;

  MyTextField({
    super.key,
    required this.hint,
    required this.title,
    required this.inputType,
    this.securedPassword = false,
    this.controller,
    this.validator,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    isVisible = widget.securedPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 20)),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: TextFormField(
            validator: widget.validator,
            decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 20),
              suffixIcon:
                  widget.securedPassword
                      ? InkWell(
                        onTap: () {
                          setState(() {
                            isVisible = !isVisible;
                          });
                        },
                        child: Icon(
                          isVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      )
                      : null,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hint,
              contentPadding: EdgeInsets.symmetric(
                vertical: 25,
                horizontal: 20,
              ),
            ),
            keyboardType: widget.inputType,
            obscureText: isVisible,
            controller: widget.controller,
          ),
        ),
      ],
    );
  }
}
