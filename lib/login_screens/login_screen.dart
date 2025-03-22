import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo/login_screens/register_screen.dart';

import '../my_theme.dart';
import 'my_text_field.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.lightPrimary,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: Center(
                    child: Image.asset('assets/images/route_logo.png'),
                  ),
                ),
                SizedBox(height: 50),
                MyTextField(
                  hint: 'enter your email address',
                  title: 'Email address',
                  inputType: TextInputType.name,
                  controller: email,
                  validator: (text) {
                    if (text?.isEmpty == true) {
                      return 'please enter your email';
                    }
                    if (EmailValidator.validate('text')) {
                      return 'invalid email';
                    }
                    return null;
                  },
                ),
                MyTextField(
                  hint: 'enter your password',
                  title: 'password',
                  inputType: TextInputType.visiblePassword,
                  securedPassword: true,
                  controller: password,
                  validator: (text) {
                    if (text?.isEmpty == true) {
                      return 'please enter password';
                    }
                    if (text!.length < 6) {
                      return 'password at least 6 characters';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            formKey.currentState?.validate();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            'login',
                            style: TextStyle(
                              color: MyTheme.lightPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "don't have an account?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacementNamed(
                            context,
                            RegisterScreen.routeName,
                          ),
                      child: Text('sign up!!', style: TextStyle(fontSize: 20)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
