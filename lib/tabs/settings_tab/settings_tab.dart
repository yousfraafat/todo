import 'package:flutter/material.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/tabs/settings_tab/setting_drawer.dart';

import '../../login_screens/login_screen.dart';
import '../../login_screens/register_screen.dart';

class SettingsTab extends StatelessWidget {
  static const String tabTitle = 'Settings';

  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SettingDrawer("English"),
          Text(
            'Theme',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SettingDrawer('Light'),
          Spacer(flex: 7),
          Center(
            child: TextButton(
              onPressed:
                  () => Navigator.pushNamed(context, RegisterScreen.routeName),
              child: Text(
                'Sign Up',
                style: TextStyle(color: MyTheme.lightPrimary, fontSize: 25),
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed:
                  () => Navigator.pushNamed(context, LoginScreen.routeName),
              child: Text(
                'Login',
                style: TextStyle(color: MyTheme.lightPrimary, fontSize: 25),
              ),
            ),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
