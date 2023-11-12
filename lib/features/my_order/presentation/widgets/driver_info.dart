import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/my_order/data/model/all_orders_model.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverInfo extends StatelessWidget {
  final String driverName;
  const DriverInfo({
    super.key, required this.driverName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 22.r,
          backgroundImage:NetworkImage(SharedHandler.instance!.getData(key: SharedKeys().user, valueType: ValueType.map)['imageUrl']),
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
                  TextStyleHelper.button13.copyWith(color: Color(0xff4F5E7B)),
            ),
            Text(
              '4.5',
              style:
                  TextStyleHelper.caption11.copyWith(color: Color(0xff4F5E7B)),
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          radius: 20.r,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: SvgPicture.asset(AppImages.paymentIcon),
        ),
      ],
    );
  }
}
