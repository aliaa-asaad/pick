import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyleHelper {
  static TextStyle get title30 => TextStyle(
        fontSize: 30.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get title24 => TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get subtitle19 => TextStyle(
        fontSize: 19.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get subtitle17 => TextStyle(
        fontSize: 17.sp,
        /* fontWeight: FontWeight.bold, */
      );
  static TextStyle get body15 => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get caption11 => TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get button13 => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.bold,
      );
}
