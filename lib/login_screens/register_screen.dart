import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo/login_screens/login_screen.dart';
import 'package:todo/login_screens/my_text_field.dart';
import 'package:todo/my_theme.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'sign up';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RegisterScreen({super.key});

  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirmation = TextEditingController();

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
                MyTextField(
                  hint: 'enter your user name',
                  title: 'User Name',
                  inputType: TextInputType.name,
                  controller: userName,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return 'please enter user name';
                    }
                    return null;
                  },
                ),
                MyTextField(
                  hint: 'enter your email address',
                  title: 'Email address',
                  inputType: TextInputType.emailAddress,
                  controller: email,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
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
                  title: 'Password',
                  inputType: TextInputType.visiblePassword,
                  securedPassword: true,
                  controller: password,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return 'please enter password';
                    }
                    if (text!.length < 6) {
                      return 'password at least 6 characters';
                    }
                    return null;
                  },
                ),
                MyTextField(
                  hint: 'enter your password again',
                  title: 'Password Confirmation',
                  inputType: TextInputType.visiblePassword,
                  securedPassword: true,
                  controller: passwordConfirmation,
                  validator: (text) {
                    if (text?.trim().isEmpty == true) {
                      return 'please enter your password';
                    }
                    if (text != password.text) {
                      return "password doesn't match";
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
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
                            'Sign Up',
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
                      'already have an account?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed:
                          () => Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          ),
                      child: Text('sign in!!', style: TextStyle(fontSize: 20)),
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
