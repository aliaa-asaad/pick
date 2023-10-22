import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3), (){
          AppRoutes.pushNamedNavigator(
                routeName: Routes.onboarding, replacement: true);
          if (SharedHandler.instance!.getData(
              key: SharedKeys().isFirstTime, valueType: ValueType.bool)) {
            AppRoutes.pushNamedNavigator(
                routeName: Routes.onboarding, replacement: true);
          } else {
            if (SharedHandler.instance!.getData(
                key: SharedKeys().isLogin, valueType: ValueType.bool)) {
              AppRoutes.pushNamedNavigator(
                  routeName: Routes.navBar, replacement: true);
            }
            else{
              AppRoutes.pushNamedNavigator(
                  routeName: Routes.auth, replacement: true);
            }
          }
        }),
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: SvgPicture.asset(
                AppImages.logo,
                fit: BoxFit.contain,
              ),
            ),
          );
        });
    /* }); */
  }
}
