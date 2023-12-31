import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/features/profile/data/view_model/bloc/profile_bloc.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/handlers/url_launcher_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedHandler.instance!.getData(
                key: SharedKeys().userType, valueType: ValueType.int) ==
            0
        ? SharedHandler.instance!
            .getData(key: SharedKeys().user, valueType: ValueType.map)
        : SharedHandler.instance!
            .getData(key: SharedKeys().driver, valueType: ValueType.map);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      /*  {
        'icon': AppImages.orderIcon4,
        'title': 'سجل الفواتير',
        'route': Routes.bills
      }, */
      {
        'icon': AppImages.settingsIcon,
        'title': 'تعديل الحساب',
        'route': Routes.editProfile
      },
      {'icon': AppImages.infoIcon, 'title': 'عن بيك أب', 'route': Routes.about},
      /* {
        'icon': AppImages.localizationIcon,
        'title': 'اللغة',
        'route': Routes.localization
      }, */
      {
        'icon': AppImages.callCenterIcon,
        'title': 'خدمة العملاء',
        'route': Routes.callCenter
      },
      {
        'icon': AppImages.policyIcon,
        'title': 'الشروط والاحكام ',
        'route': Routes.policy
      },
      {
        'icon': AppImages.deleteIcon,
        'title': 'الغاء الحساب',
        //'route': Routes.check
      },
      {
        'icon': AppImages.logoutIcon,
        'title': 'تسجيل الخروج',
        'route': Routes.check
      },
    ];
    Future<void> showMyDialog(BuildContext context,
        {required String title,
        required String question,
        required void Function() yesOnPressed}) async {
      return showDialog<void>(
        barrierColor: Colors.grey.shade400.withOpacity(.2),
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            backgroundColor: Colors.white,
            shadowColor: Colors.grey.shade300,
            // title: Text(title),titlePadding: ,
            alignment: const FractionalOffset(0.37, 0.35),
            content: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4.r)),
              height: 140,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  Divider(),
                  Text(
                    title,
                    style: TextStyleHelper.subtitle17
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    question,
                    style: TextStyleHelper.body15,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(MediaQueryHelper.width * .25, 32),
                            backgroundColor: Colors.red),
                        onPressed: yesOnPressed,
                        child: const Text(
                          'نعم',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            minimumSize: Size(MediaQueryHelper.width * .24, 28),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r)),
                            backgroundColor: Colors.grey.shade300),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'لا',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );

          // barrierDismissible: false,
        },
      );
    }

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary,
            /* Colors.white,Colors.white,Colors.white */
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(children: [
              SizedBox(
                height: MediaQueryHelper.height * .059,
              ),
              CircleAvatar(
                radius: 55.r,
                backgroundImage: NetworkImage(SharedHandler.instance!.getData(
                            key: SharedKeys().userType,
                            valueType: ValueType.int) ==
                        0
                    ? SharedHandler.instance!.getData(
                        key: SharedKeys().user,
                        valueType: ValueType.map)['imageUrl']
                    : SharedHandler.instance!.getData(
                        key: SharedKeys().driver,
                        valueType: ValueType.map)['imageUrl']),
              ),
              SizedBox(
                height: MediaQueryHelper.height * .01,
              ),
              Text(
                SharedHandler.instance!.getData(
                            key: SharedKeys().userType,
                            valueType: ValueType.int) ==
                        0
                    ? SharedHandler.instance!.getData(
                        key: SharedKeys().user,
                        valueType: ValueType.map)['fullName']
                    : SharedHandler.instance!.getData(
                        key: SharedKeys().driver,
                        valueType: ValueType.map)['fullName'],
                style: TextStyleHelper.subtitle17.copyWith(color: Colors.white),
              ),
              /*  SizedBox(
              height: MediaQueryHelper.height * .01,
            ), */
              Text(
                SharedHandler.instance!.getData(
                            key: SharedKeys().userType,
                            valueType: ValueType.int) ==
                        0
                    ? SharedHandler.instance!.getData(
                        key: SharedKeys().user,
                        valueType: ValueType.map)['phoneNumber']
                    : SharedHandler.instance!.getData(
                        key: SharedKeys().driver,
                        valueType: ValueType.map)['phoneNumber'],
                style: TextStyleHelper.subtitle17.copyWith(color: Colors.white),
              ),
              //  const Spacer(),
              SizedBox(
                height: MediaQueryHelper.height * .06,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16.r),
                  ),
                ),
                width: MediaQueryHelper.width,
                height: 450,
                child: Column(
                  children: List.generate(
                    content.length,
                    (index) => InkWell(
                      onTap: () {
                        if (index == content.length - 1) {
                          showMyDialog(context,
                              title: 'تسجيل الخروج',
                              question: 'هل تريد تسجيل الخروج؟',
                              yesOnPressed: () {
                            AuthBloc.instance.add(LogoutClick());
                          });
                        } else if (index == content.length - 2) {
                          showMyDialog(context,
                              title: 'الغاء الحساب',
                              question: 'هل تريد الغاء الحساب؟',
                              yesOnPressed: () {
                            ProfileBloc.instance.add(DeleteAccount());
                          });
                        } else if (index == 1) {
                          UrlLauncherHandler.openURL(
                              url: 'https://pickupksa.com/About');
                        } else if (index == 2) {
                          UrlLauncherHandler.openURL(
                              url: 'https://pickupksa.com/ConnectUs');
                        } else if (index == 3) {
                          UrlLauncherHandler.openURL(
                              url: 'https://pickupksa.com/PrivacyPolicy.html');
                        } else {
                          AppRoutes.pushNamedNavigator(
                              routeName: content[index]['route']);
                        }
                      },
                      child: ListTile(
                        minLeadingWidth: 20.w,
                        minVerticalPadding: MediaQueryHelper.height * .008,
                        trailing: Icon(
                          Platform.isIOS
                              ? Icons.arrow_forward_ios
                              : Icons.arrow_forward,
                          size: MediaQueryHelper.height * .025,
                          color: index == content.length - 1
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          "${content[index]['title']}",
                          style: TextStyleHelper.subtitle17.copyWith(
                            fontWeight: FontWeight.bold,
                            color: index == content.length - 1
                                ? Colors.red
                                : const Color(0xff4F5E7B),
                          ),
                        ),
                        leading: SvgPicture.asset(
                          content[index]['icon'],
                          height: MediaQueryHelper.height * .025,
                          color: index == content.length - 1
                              ? Colors.red
                              : Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
