import 'package:flutter/material.dart';

import '../../../../my_theme.dart';

class SettingDrawer extends StatelessWidget {
  String text;

  SettingDrawer(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, bottom: 25, top: 25),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: MyTheme.lightPrimary, width: 1.5),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: TextStyle(color: MyTheme.lightPrimary, fontSize: 20),
          ),
          Spacer(),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            color: MyTheme.lightPrimary,
            size: 30,
          ),
        ],
      ),
    );
  }
}
