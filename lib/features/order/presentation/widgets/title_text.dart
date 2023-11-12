import 'package:flutter/material.dart';
import 'package:pick_up/utilities/text_style.dart';

class TitleText extends StatelessWidget {
  final String title;
  const TitleText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyleHelper.subtitle19,
    );
  }
}
