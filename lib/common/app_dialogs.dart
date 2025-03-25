import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';

class DialogButton extends StatelessWidget {
  String text;
  VoidCallback onTap;

  DialogButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: MyTheme.lightPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(text, style: TextStyle(fontSize: 20)),
    );
  }
}

void showMessageDialog({
  required BuildContext context,
  required String message,
  String? posButtonText,
  VoidCallback? posButtonTap,
  String? negButtonText,
  VoidCallback? negButtonTap,
  bool cancelable = true,
}) {
  List<Widget> actions = [];
  if (posButtonText != null) {
    actions.add(
      DialogButton(
        text: posButtonText,
        onTap:
            posButtonTap == null ? () => Navigator.pop(context) : posButtonTap,
      ),
    );
  }
  if (negButtonText != null) {
    actions.add(
      DialogButton(
        text: negButtonText,
        onTap:
            negButtonTap == null ? () => Navigator.pop(context) : negButtonTap,
      ),
    );
  }
  showDialog(
    barrierDismissible: cancelable,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(message),
        actions: actions,
        contentTextStyle: TextStyle(fontSize: 20, color: Colors.black),
        contentPadding: EdgeInsets.all(30),
      );
    },
  );
}

void showLoadingDialog({
  required BuildContext context,
  required String message,
  bool cancelable = true,
}) {
  showDialog(
    barrierDismissible: cancelable,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(
              color: MyTheme.lightPrimary,
              padding: EdgeInsets.all(15),
            ),
            Expanded(child: Text(message, style: TextStyle(fontSize: 25))),
          ],
        ),
      );
    },
  );
}

void popDialog(BuildContext context) {
  Navigator.pop(context);
}
