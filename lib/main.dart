import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/my_theme.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/screens/home_screen/home_screen.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppAuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppAuthProvider authProvider = Provider.of<AppAuthProvider>(context);
    return MaterialApp(
      title: 'todo',
      initialRoute:
          authProvider.isLoggedIn()
              ? HomeScreen.routeName
              : LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
      },
      theme: MyTheme.lightTheme,
      themeMode: ThemeMode.light,
    );
  }
}
