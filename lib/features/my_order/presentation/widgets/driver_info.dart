import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverInfo extends StatelessWidget {
  final String driverName;
  const DriverInfo({
    super.key,
    required this.driverName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 22.r,
          backgroundImage: NetworkImage
          (SharedHandler.instance!.getData(
                  key: SharedKeys().user,
                  valueType: ValueType.map)['imageUrl'] ??
              'https://th.bing.com/th/id/R.98f7ba11c0008416714360d79b38fcc3?rik=2Ejragac6mGlFQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2fuser-png-icon-thin-line-user-icon-2232.png&ehk=xfJZe9qWw%2fORWGP1VnUnQPT3r09SLw4ihK%2fyNms%2b2OA%3d&risl=&pid=ImgRaw&r=0',scale: 6),
        ),
        SizedBox(
          width: MediaQueryHelper.width * .05,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              driverName,
              style:
                  TextStyleHelper.button13.copyWith(color: const Color(0xff4F5E7B)),
            ),
            Text(
              '4.5',
              style:
                  TextStyleHelper.caption11.copyWith(color: const Color(0xff4F5E7B)),
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: SvgPicture.asset(AppImages.paymentIcon),
        ),
      ],
    );
  }
}
