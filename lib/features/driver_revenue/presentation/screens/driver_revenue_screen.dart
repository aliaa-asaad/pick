import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/driver_revenue/presentation/widgets/total_price.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverRevenueScreen extends StatelessWidget {
  const DriverRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('الارباح',
            style: TextStyleHelper.subtitle19
                .copyWith(color: Theme.of(context).colorScheme.primary)),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TotalPrice(),
                const TotalPrice(),
                SizedBox(
                  height: MediaQueryHelper.height * .01,
                ),
                /* Column(
                  children: List.generate(
                    4,
                    (index) => Container(
                      padding: EdgeInsets.all(16.r),
                      margin: EdgeInsets.only(
                          bottom: MediaQueryHelper.height * .01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ارباح طلب توصيل اغراض',
                                style: TextStyleHelper.subtitle17.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Text(
                                'رقم الطلب 34234  بتاريخ 2023/2/23',
                                style: TextStyleHelper.button13.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff4F5E7B),
                                ),
                              )
                            ],
                          ),
                          Text(
                            '+200',
                            style: TextStyleHelper.button13.copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                 */Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQueryHelper.height * .11,
                      width: MediaQueryHelper.width * .4,
                      padding: EdgeInsets.all(8.r),
                      margin: EdgeInsets.only(
                          bottom: MediaQueryHelper.height * .01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'عدد الرحلات',
                            style: TextStyleHelper.subtitle19.copyWith(
                                color: const Color(0xff4F5E7B).withOpacity(.5)),
                          ),
                          Text('4 رحلات', style: TextStyleHelper.body15),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQueryHelper.height * .11,
                      width: MediaQueryHelper.width * .4,
                      padding: EdgeInsets.all(8.r),
                      margin: EdgeInsets.only(
                          bottom: MediaQueryHelper.height * .01),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'التقييم',
                            style: TextStyleHelper.subtitle19.copyWith(
                                color: const Color(0xff4F5E7B).withOpacity(.5)),
                          ),
                          Text('4', style: TextStyleHelper.body15),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
