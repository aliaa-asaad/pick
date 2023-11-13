import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class CustomOrderAppBar extends StatelessWidget {
  const CustomOrderAppBar({
    super.key,
    required this.icons,
    required this.currentStep,
    this.isDriver = false,
  });

  final List<Map<String, dynamic>> icons;
  final int currentStep;
  final bool isDriver;

  @override
  Widget build(BuildContext context) {
    Path customPath = Path()
      ..moveTo(-60.w, 0.w)
      ..lineTo(0.w, 0.w);
    int dashIndex = 2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.r),
      height: MediaQueryHelper.height * .13,
      decoration: BoxDecoration(
          color:
              isDriver ? Theme.of(context).colorScheme.primary : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          icons.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                   CircleAvatar(
                          radius: 26.r,
                          backgroundColor: currentStep > index
                              ? Colors.green
                              : isDriver
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary,
                          child: CircleAvatar(
                            radius: 25.r,
                            backgroundColor: currentStep > index
                                ? Colors.green
                                : currentStep == index
                                    ? isDriver
                                        ? Colors.white
                                        : Theme.of(context).colorScheme.primary
                                    : isDriver
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.white,
                            child: currentStep > index
                                ? const Icon(Icons.check_circle,
                                    color: Colors.white)
                                : SvgPicture.asset(
                                    icons[index]['icon'],height: MediaQueryHelper.height * .025,
                                    color: currentStep == index
                                        ? isDriver
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Colors.white
                                        : isDriver
                                            ? Colors.white
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                  ),
                          ),
                        ),
                  index <= icons.length - dashIndex
                      ? DottedBorder(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          customPath: (size) => customPath,
                          color: currentStep > index
                              ? isDriver
                                  ? Colors.white
                                  : Colors.green
                              : isDriver
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary,
                          dashPattern: const [6, 3],
                          strokeWidth: 1,
                          child: const SizedBox())
                      : const SizedBox()
                ],
              ),
              Text(
                      icons[index]['title'],
                      style: TextStyleHelper.body15.copyWith(color: currentStep == index
                              ? isDriver
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.primary
                              : isDriver
                                  ? Colors.white.withOpacity(.4)
                                  : Colors.grey)
                          ,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
