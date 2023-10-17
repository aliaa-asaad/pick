import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/text_style.dart';

class CheckCard extends StatelessWidget {
  final String title;
  final String image;
  final Color color;
  final Function() onTap;
  const CheckCard(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        /* margin: EdgeInsets.only(right:8.w), */

        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 42.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: color,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 8,
                  offset: const Offset(0, 0))
            ]),
        child: Column(
          children: [
            Image.asset(image),
            const Spacer(),
            Text(title, style: TextStyleHelper.body16)
          ],
        ),
      ),
    );
  }
}
