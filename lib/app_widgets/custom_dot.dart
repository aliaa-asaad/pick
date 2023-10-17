import 'package:flutter/material.dart';

class CustomDot extends StatelessWidget {
  final int currentIndex;
  final int index;
  final Color color;
  const CustomDot(
      {super.key,
      required this.currentIndex,
      required this.index,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
    );
  }
}
