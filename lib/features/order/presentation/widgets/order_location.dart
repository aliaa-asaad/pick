import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderLocation extends StatelessWidget {
  final String title;
  final String location;
  final bool isDetails;
  const OrderLocation({
    super.key,
    required this.title,
    required this.location,
    this.isDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQueryHelper.height * .01,
        ),
        Row(
          children: [
            isDetails
                ? CircleAvatar(
                    radius: 5.r,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    // child: Icon(Icons.check),
                  )
                : const SizedBox(),
            isDetails
                ? SizedBox(
                    width: MediaQueryHelper.width * .03,
                  )
                : const SizedBox(),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xff001833)),
            ),
          ],
        ),
        SizedBox(
          height: MediaQueryHelper.height * .01,
        ),
        Row(
          children: [
            isDetails
                ? CircleAvatar(
                    radius: 5.r,
                    backgroundColor: const Color(0xff4F5E7B),
                    // child: Icon(Icons.check),
                  )
                : const SizedBox(),
            isDetails
                ? SizedBox(
                    width: MediaQueryHelper.width * .03,
                  )
                : const SizedBox(),
            SvgPicture.asset(AppImages.locationIcon),
            SizedBox(
              width: MediaQueryHelper.width * .02,
            ),
            Text(
              location,
              style: const TextStyle(
                color: Color(0xff4F5E7B),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
