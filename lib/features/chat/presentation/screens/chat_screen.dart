import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Colors.white,
        title: const Text(
          'الرسائل',
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
              (index) => Column(
                    children: [
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30.r,
                            //backgroundImage: AssetImage('assets/images/profile.png'),
                          ),
                          SizedBox(
                            width: MediaQueryHelper.width * .02,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mohamed Ahmed',
                                style: TextStyleHelper.subtitle17
                                    .copyWith(color: const Color(0xff4F5E7B)),
                              ),
                              Text(
                                'مندوب طلب رقم 34243',
                                style: TextStyleHelper.button13.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xff4F5E7B)
                                        .withOpacity(.5)),
                              )
                            ],
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            AppImages.whatsappIcon,
                            // width: 20.r,
                            height: MediaQueryHelper.height * .05,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      const Divider(
                        color: Colors.white,
                        thickness: 2,
                      )
                    ],
                  )),
        ),
      )),
    );
  }
}
