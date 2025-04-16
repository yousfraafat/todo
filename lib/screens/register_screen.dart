import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/common/app_dialogs.dart';
import 'package:todo/common/exception_codes.dart';
import 'package:todo/common/my_text_field.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/screens/login_screen.dart';

import '../providers/app_auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'sign up';

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    if (EmailValidator.validate('$text') == false) {
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
                            register();
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

  void register() {
    if (formKey.currentState?.validate() == true) {
      createAccount();
    }
    return;
  }

  Future<void> createAccount() async {
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
      final user = await authProvider.createUserWithEmailAndPassword(
        email.text,
        password.text,
        userName.text,
      );
      if (user == null) {
        popDialog(context);
        showMessageDialog(
          context: context,
          message: message,
          posButtonText: 'try again',
          posButtonTap: () => register(),
        );
        return;
      }
      popDialog(context);
      showMessageDialog(
        context: context,
        message: 'account created successfully!',
        posButtonText: 'ok',
        posButtonTap:
            () =>
                Navigator.pushReplacementNamed(context, LoginScreen.routeName),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == ExceptionCodes.weakPassword) {
        message = 'password is too weak.';
      } else if (e.code == ExceptionCodes.emailInUse) {
        message = 'The account already exists for that email.';
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
        posButtonTap: () => register(),
      );
    }
  }
}
