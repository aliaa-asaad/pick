import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ConfirmAdditionalServices extends StatelessWidget {
  final String title;
  final String type;
  final int? isAvailable;
  final bool isDetails;
  const ConfirmAdditionalServices(
      {super.key,
      required this.title,
      required this.type,
      this.isAvailable,
      this.isDetails = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0.r),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5.r,
            backgroundColor: Theme.of(context).colorScheme.primary,
            // child: Icon(Icons.check),
          ),
          SizedBox(
            width: MediaQueryHelper.width * .03,
          ),
          Text(
            title,
            style: TextStyleHelper.body15.copyWith(
                color: const Color(0xff001833), fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 5.r,
            backgroundColor: isAvailable == 0 ? Colors.green : Colors.red,
            // child: Icon(Icons.check),
          ),
          SizedBox(
            width: MediaQueryHelper.width * .03,
          ),
          Text(
            type,
            style: TextStyleHelper.body15
                .copyWith(color: isAvailable == 0 ? Colors.green : Colors.red),
          ),
          isAvailable == 0
              ? SizedBox(
                  width: MediaQueryHelper.width * .06,
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
