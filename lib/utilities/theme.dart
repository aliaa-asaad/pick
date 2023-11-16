import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.black),
    fontFamily: 'Cairo',
    appBarTheme: AppBarTheme(titleTextStyle: TextStyle(fontFamily: 'Cairo')),
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
    scaffoldBackgroundColor: Color(0xffF4F4F5),
    colorScheme: ColorScheme.light(
      
      primary: const Color(0xff5BD881),
      secondary: const Color(0xffFF7E3D),
      // background: const Color(0xff2F80ED).withOpacity(.3),
      brightness: Brightness.light,
      primaryContainer: Colors.white,
      secondaryContainer: Colors.grey,
    ),
  );
}
