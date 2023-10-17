import 'package:flutter/material.dart';
import 'package:pick_up/utilities/media_quary.dart';

class Floor extends StatelessWidget {
  const Floor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQueryHelper.height * .01,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'حدد طابق الاستلام',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: MediaQueryHelper.height * .01,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'حدد طابق التسليم',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(
          height: MediaQueryHelper.height * .01,
        ),
      ],
    );
  }
}
