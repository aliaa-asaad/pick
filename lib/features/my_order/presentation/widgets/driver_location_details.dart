import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverLocationDetails extends StatelessWidget {
  final String pickupLocation;
  final String deliveryLocation;
  const DriverLocationDetails({
    super.key, required this.pickupLocation, required this.deliveryLocation,
  });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> locationDetails = [
      {
        'icon': AppImages.locationIcon,
        'title': 'موقع استلام البضائع',
        'subtitle':pickupLocation,
           
      },
      {
        'icon': AppImages.costIcon,
        'title': 'تكلفة الطلب',
        'subtitle': 'ريال 250',
      },
      {
        'icon': AppImages.locationIcon,
        'title': 'موقع توصيل البضائع',
        'subtitle':deliveryLocation
      },
      {
        'icon': AppImages.revenueIcon,
        'title': 'طريقة الدفع',
        'subtitle': 'فيزا',
      },
    ];

    return SizedBox(
      height: MediaQueryHelper.height * .16,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: locationDetails.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6 / 5,
          crossAxisSpacing: MediaQueryHelper.width * .06,
          mainAxisSpacing: MediaQueryHelper.height * .01,
          mainAxisExtent: MediaQueryHelper.height * .07,
        ),
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22.r,
              backgroundColor: Colors.grey.shade300,
              child: SvgPicture.asset(
                locationDetails[index]['icon'],
                color: const Color(0xff4F5E7B),
              ),
            ),
            SizedBox(
              width: MediaQueryHelper.width * .02,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationDetails[index]['title'],
                  style: TextStyleHelper.caption11
                      .copyWith(color: const Color(0xff4F5E7B).withOpacity(.5)),
                ),
                Text(locationDetails[index]['subtitle'],
                    style: TextStyleHelper.caption11
                        .copyWith(color: const Color(0xff4F5E7B))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
