import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_dot.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController _controller1 = PageController();
  PageController _controller2 = PageController();

  @override
  void initState() {
    _controller1 = PageController(initialPage: 0);
    _controller2 = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea( bottom:Platform.isIOS? false:true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQueryHelper.height * .4,
              child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller1,
                itemCount: onBoardingList.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) =>
                    Image.asset(onBoardingList[index]['image']),
              ),
              //  width: MediaQueryHelper.width,
            ),
            SizedBox(height: MediaQueryHelper.height * .1),
            Container(
              width: MediaQueryHelper.width,
              height: MediaQueryHelper.height * .225,
              padding: EdgeInsets.only(top: 28.h),
              decoration:  BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36.r),
                    topRight: Radius.circular(36.r),
                  ),
                  color: Colors.white),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onBoardingList.length,
                      (index) => CustomDot(
                          color: currentIndex == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey,
                          currentIndex: currentIndex,
                          index: index),
                    ),
                  ),
                  SizedBox(height: MediaQueryHelper.height * .01),
                  SizedBox(
                    height: MediaQueryHelper.height * .16,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _controller2,
                      itemCount: onBoardingList.length,
                      onPageChanged: (int index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      itemBuilder: (context, index) => Column(children: [
                        Text(onBoardingList[index]['title'],
                            textAlign: TextAlign.center,
                            style: TextStyleHelper.title24),
                        SizedBox(height: MediaQueryHelper.height * .005),
                        Padding(
                          padding:  EdgeInsets.fromLTRB(12.0.r,0,12.0.r,8.0.r),
                          child: Text(onBoardingList[index]['description'],
                              textAlign: TextAlign.center,
                              style: TextStyleHelper.body15
                                  .copyWith(color: Colors.grey)),
                        ),
                        /* SizedBox(height: MediaQueryHelper.height * .01), */
                      const Spacer(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQueryHelper.width,
              padding: EdgeInsets.fromLTRB(16.r, 0, 16.r, 16.r),
              child: CustomButton(
                  textColor: currentIndex == onBoardingList.length - 1
                      ? Colors.white
                      : Theme.of(context).colorScheme.secondary,
                  background: currentIndex == onBoardingList.length - 1
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(.16),
                  onPressed: () {
                    if (currentIndex == onBoardingList.length - 1) {
                      AppRoutes.pushNamedNavigator(
                          routeName: Routes.check, replacement: true);
                    }
                    _controller1.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    );
                    _controller2.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeInOut,
                    );
                  },
                  text: currentIndex == onBoardingList.length - 1
                      ? "لنبدأ الآن"
                      : "التالي"),
            ),
            /* Container(
              height: MediaQueryHelper.height,
              width: MediaQueryHelper.width,
              /* decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary), */
              child: Stack(
                children: [
                  PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: _controller,
                    itemCount: onBoardingList.length,
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemBuilder: (_, index) {
                      return Column(
                        /* 
                      mainAxisAlignment: MainAxisAlignment.center, */
                        children: [
                          SizedBox(
                            height: MediaQueryHelper.height * .1,
                          ),
                          Image.asset(onBoardingList[index]['image']),
                          const Spacer(),
                          Container(
                            width: MediaQueryHelper.width,
                            height: MediaQueryHelper.height * .34,
                            padding: EdgeInsets.only(top: 28.h),
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(36),
                                    topRight: Radius.circular(36)),
                                color: Colors.white),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  onBoardingList.length,
                                  (index) => CustomDot(
                                      color: currentIndex == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey,
                                      currentIndex: currentIndex,
                                      index: index),
                                ),
                              ),
                              SizedBox(height: MediaQueryHelper.height * .01),
                              Text(onBoardingList[index]['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyleHelper.title25),
                              SizedBox(height: MediaQueryHelper.height * .005),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    onBoardingList[index]['description'],
                                    textAlign: TextAlign.center,
                                    style: TextStyleHelper.body16
                                        .copyWith(color: Colors.grey)),
                              ),
                              /* SizedBox(height: MediaQueryHelper.height * .01), */
                              const Spacer(),
                              CustomButton(
                                  textColor: currentIndex ==
                                          onBoardingList.length - 1
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.primary,
                                  background: currentIndex ==
                                          onBoardingList.length - 1
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.secondary,
                                  onPressed: () {
                                    if (currentIndex ==
                                        onBoardingList.length - 1) {
                                      AppRoutes.pushNamedNavigator(
                                          routeName: Routes.check,
                                          replacement: true);
                                    }
                                    _controller.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.decelerate,
                                    );
                                  },
                                  text:
                                      currentIndex == onBoardingList.length - 1
                                          ? "لنبدأ الآن"
                                          : "التالي"),
                            ]),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
           */
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> onBoardingList = [
  {
    'title': 'نقل وتوصيل البضائع',
    'description': 'بيك أب لنقل وتوصيل البضائع من والى اى مكان ترغب فيه',
    'image': AppImages.onBoarding1,
  },
  {
    'title': 'اختار العرض اللى يناسبك',
    'description': 'قدم طلب و اختار العرض اللى يناسبك مع المندوب وابدا فورآ',
    'image': AppImages.onBoarding2,
  },
  {
    'title': 'تابع طلبك أول بأول',
    'description': 'تابع طلبك مباشرآ مع المندوب وتواصل معه عبر الرسائل',
    'image': AppImages.onBoarding3,
  },
];
