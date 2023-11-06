import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ClientInfo extends StatelessWidget {
  const ClientInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
        ),
        SizedBox(
          width: MediaQueryHelper.width * .05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'محمد عبد الله',
              style: TextStyleHelper.button14
                  .copyWith(
                      color: Color(0xff4F5E7B)),
            ),
            Text(
              '4.5',
              style: TextStyleHelper.caption12
                  .copyWith(color: Color(0xff4F5E7B)),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 20.r,
          backgroundColor:
              Theme.of(context).colorScheme.secondary,
          child:
              SvgPicture.asset(AppImages.paymentIcon),
        ),
      ],
    );
  }
}
