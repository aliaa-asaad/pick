import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final String? text;
  final Color? background;
  final Color? textColor;

  final Widget? child;
  final double? width;
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.text,
      this.background,
      this.textColor,
      this.child,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: AnimatedContainer(
          // padding: EdgeInsets.symmetric(horizontal: 16.w),
          width: width ?? MediaQueryHelper.width,
          margin: EdgeInsets.symmetric(
            vertical: 8.r, /* horizontal: 16.r */
          ),
          height: 50,
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          /* padding: EdgeInsets.symmetric(
                            vertical: 8.r, horizontal: 32.r), */
          decoration: BoxDecoration(
              color: background ?? Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(24.r)

              /* shape: state is RegisterLoading
                              ? BoxShape.circle
                              : null, */
              ),
          duration: const Duration(seconds: 1),
          child: child ??
              Text(text!,
                  style: TextStyleHelper.subtitle19
                      .copyWith(color: textColor ?? Colors.white)),
        ),
      ),
    );
  }
}
