import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    iconTheme: const IconThemeData(color: Colors.black),
    fontFamily: 'Cairo',
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff981A1E),
    ),
    scaffoldBackgroundColor: Color(0xffF4F4F5),
    
    colorScheme: ColorScheme.light(
      primary: const Color(0xffF3C857),
      secondary: const Color(0xffFBD83D).withOpacity(0.2),
      // background: const Color(0xff2F80ED).withOpacity(.3),
      brightness: Brightness.light,
      primaryContainer:  Colors.white,
      secondaryContainer:  Colors.grey,
    ),
  );
}
