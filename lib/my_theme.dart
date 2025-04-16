import 'package:flutter/material.dart';

class MyTheme {
  static final Color lightSecondary = Color(0xffDFECDB);
  static final Color lightPrimary = Color(0xff5D9CEC);
  static final ThemeData lightTheme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: lightPrimary),
    ),
    timePickerTheme: TimePickerThemeData(
      dayPeriodColor: lightPrimary,
      dialBackgroundColor: lightSecondary,
      dialHandColor: lightPrimary,
      cancelButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
      ),
      confirmButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      dayForegroundColor: WidgetStatePropertyAll(Colors.black),
      headerForegroundColor: Colors.white,
      headerBackgroundColor: lightPrimary,
      todayForegroundColor: WidgetStatePropertyAll(Colors.black),
      cancelButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
      ),
      confirmButtonStyle: ElevatedButton.styleFrom(
        backgroundColor: lightPrimary,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightPrimary,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: lightPrimary, size: 40),
      unselectedIconTheme: IconThemeData(color: Color(0xffC8C9CB), size: 40),
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: CircleBorder(side: BorderSide(width: 5, color: Colors.white)),
      backgroundColor: lightPrimary,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
      padding: EdgeInsets.all(3),
      color: Colors.white,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightPrimary,
      primary: lightSecondary,
      secondary: lightPrimary,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
  );
}
