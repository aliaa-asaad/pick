import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class TextStyleHelper {
  static TextStyle get title25 =>  TextStyle(
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get subtitle20 =>  TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      );
      static TextStyle get subtitle18 =>  TextStyle(
        fontSize: 18.sp,
        /* fontWeight: FontWeight.bold, */
      );
  static TextStyle get body16 =>  TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get caption12 =>  TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get button14 =>  TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
      );
}
