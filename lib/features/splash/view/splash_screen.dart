import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3), () async {
          /* AppRoutes.pushNamedNavigator(
                routeName: Routes.onboarding, replacement: true); */

          if (SharedHandler.instance!.getData(
              key: SharedKeys().isNotFirstTime, valueType: ValueType.bool)) {
            log('isFirstTime=false');
            if (SharedHandler.instance!.getData(
                key: SharedKeys().isLogin, valueType: ValueType.bool)) {
              SharedHandler.instance!.getData(
                          key: SharedKeys().userType,
                          valueType: ValueType.int) ==
                      0
                  ? AppRoutes.pushNamedNavigator(
                      routeName: Routes.clientNavBar, replacement: true)
                  : AppRoutes.pushNamedNavigator(
                      routeName: Routes.driverNavBar, replacement: true);
            } else {
              AppRoutes.pushNamedNavigator(
                  routeName: Routes.check, replacement: true);
            }
           
          } else {
             AppRoutes.pushNamedNavigator(
                routeName: Routes.onboarding, replacement: true);
          }
        }),
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Image.asset(
                AppImages.logo,
                fit: BoxFit.contain,
                height: MediaQueryHelper.height * .4,
                width: MediaQueryHelper.width * .6,
              ),
            ),
          );
        });
    /* }); */
  }
}
