import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Colors.white,
        title: const Text(
          'الاشعارات',
        ),
        titleTextStyle: TextStyleHelper.subtitle19.copyWith(
            color: Theme.of(context).colorScheme.primary, fontFamily: 'Cairo'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.r),
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: List.generate(
              5,
              (index) => Container(
                    padding: EdgeInsets.fromLTRB(8.r, 4.r, 8.r, 12.r),
                    margin: EdgeInsets.only(bottom: 12.h),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            icon: const Icon(Icons.close)),
                       
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 25.r,
                                  //backgroundImage: AssetImage('assets/images/profile.png'),
                                ),
                                SizedBox(
                                  width: MediaQueryHelper.width * .02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Mohamed Ahmed',
                                          style: TextStyleHelper.body15.copyWith(
                                              color: const Color(0xff20384B)),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'لقد تم توصيل طلبك !',
                                      style: TextStyleHelper.caption11.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xff334D64)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                          child: Text(
                            '10:45 AM',
                            style: TextStyleHelper.caption11.copyWith(
                                fontWeight: FontWeight.normal,
                                color: const Color(0xff334D64)),
                          ),
                        ), ],
                        ),
                      ],
                    ),
                  )),
        ),
      )),
    );
  }
}
