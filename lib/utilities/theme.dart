import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.black),
    fontFamily: 'Cairo',
    appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(fontFamily: 'Cairo')),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffFF7E3D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xffFF7E3D),
    ),
    scaffoldBackgroundColor: const Color(0xffF4F4F5),
    colorScheme: const ColorScheme.light(
      
      primary: Color(0xff5BD881),
      secondary: Color(0xffFF7E3D),
      // background: const Color(0xff2F80ED).withOpacity(.3),
      brightness: Brightness.light,
      primaryContainer: Colors.white,
      secondaryContainer: Colors.grey,
    ),
  );
}
