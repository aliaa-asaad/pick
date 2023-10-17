import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQueryHelper.height,
          width: MediaQueryHelper.width,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            /* 
                mainAxisAlignment: MainAxisAlignment.center, */
            children: [
              SizedBox(
                height: MediaQueryHelper.height * .05,
              ),
              Image.asset(AppImages.onBoarding4),
              Text(
                'بيك أب \nالأفضل والأسرع والأمن',
                style: TextStyleHelper.title25,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                  textColor: Colors.white,
                  background: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    AppRoutes.pushNamedNavigator(
                      routeName: Routes.signUp,
                    );
                  },
                  text: 'إنشاء حساب'),
              CustomButton(
                  textColor: Theme.of(context).colorScheme.primary,
                  background: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    AppRoutes.pushNamedNavigator(
                      routeName: Routes.login,
                    );
                  },
                  text: 'تسجيل الدخول'),
            ],
          ),
        ),
      ),
    );
  }
}
