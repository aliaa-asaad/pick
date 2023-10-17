import 'package:flutter/material.dart';

abstract class TextStyleHelper {
  static TextStyle get title25 => const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get subtitle20 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get body16 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get caption12 => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get button14 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
}
