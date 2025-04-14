import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/login_screens/register_screen.dart';

import '../common/app_dialogs.dart';
import '../common/exception_codes.dart';
import '../common/my_text_field.dart';
import '../my_theme.dart';
import '../providers/app_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login';

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    if (EmailValidator.validate(text!) == false) {
                      return 'wrong email';
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
                            login();
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

  void login() {
    if (formKey.currentState?.validate() == true) {
      signIn();
    }
    return;
  }

  Future<void> signIn() async {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(
      context,
      listen: false,
    );
    String message = 'something went wrong';
    try {
      showLoadingDialog(
        context: context,
        message: 'please wait ...',
        cancelable: false,
      );
      final user = await authProvider.signInWithEmailAndPassword(
        email.text,
        password.text,
      );
      if (user == null) {
        popDialog(context);
        showMessageDialog(
          context: context,
          message: message,
          posButtonText: 'try again',
          posButtonTap: () => login(),
        );
        return;
      }
      popDialog(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == ExceptionCodes.userNotFound ||
          e.code == ExceptionCodes.wrongPassword) {
        message = 'wrong email or password';
      }
      popDialog(context);
      showMessageDialog(
        context: context,
        message: message,
        posButtonText: 'ok',
      );
    } catch (e) {
      popDialog(context);
      showMessageDialog(
        context: context,
        message: message,
        posButtonText: 'try again',
        posButtonTap: () => login(),
      );
    }
  }
}
