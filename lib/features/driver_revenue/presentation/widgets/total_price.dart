import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/text_style.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
       color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                'الرصيد الاجمالي',
                style: TextStyleHelper.button13.copyWith(
                    color: const Color(
                      0xff4F5E7B,
                    ),
                    fontWeight: FontWeight.normal),
              ),
              Text.rich(
                TextSpan(
                  text: '200',
                  style: TextStyleHelper.title30.copyWith(
                    //  fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary),
                  children: [
                    TextSpan(
                      text: ' ريال',
                      style: TextStyleHelper.button13.copyWith(
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context)
                              .colorScheme
                              .primary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          /* Column(
            children: [
              CircleAvatar(
                  radius: 20.r,
                  backgroundColor:
                      Theme.of(context).colorScheme.secondary,
                  child: SvgPicture.asset(
                    AppImages.takeRevenueIcon,
                 height: MediaQuery.of(context).size.height*0.025,
                   
                  
                  ),),
              Text('سحب الارباح',
                  style: TextStyleHelper.button13.copyWith(
                    fontWeight: FontWeight.normal,
                    color: Color(
                      0xff4F5E7B,
                    ),
                  ))
            ],
          )
        */ ],
      ),
    );
  }
}
