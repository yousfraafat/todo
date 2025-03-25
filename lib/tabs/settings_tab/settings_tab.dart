import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_dialogs.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/tabs/settings_tab/setting_drawer.dart';

import '../../login_screens/login_screen.dart';
import '../../login_screens/register_screen.dart';

class SettingsTab extends StatelessWidget {
  static const String tabTitle = 'Settings';

  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
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
          Spacer(flex: 8),
          authProvider.isLoggedIn()
              ? Center(
            child: TextButton(
              onPressed: () {
                showMessageDialog(
                  context: context,
                  message: 'do you want to sign out from your account?',
                  posButtonText: 'yes',
                  posButtonTap: () {
                    authProvider.logout();
                    Navigator.pushReplacementNamed(
                      context,
                      LoginScreen.routeName,
                    );
                  },
                  negButtonText: 'no',
                  negButtonTap: () {
                    Navigator.pop(context);
                  },
                );
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ),
          )
              : Column(
            children: [
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  child: Text(
                    'login',
                    style: TextStyle(
                      color: MyTheme.lightPrimary,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, RegisterScreen.routeName);
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: MyTheme.lightPrimary,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
