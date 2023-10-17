import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(24.0.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'نسيت كلمة المرور',
              style: TextStyleHelper.title25,
            ),
            SizedBox(
              height: MediaQueryHelper.height * .02,
            ),

            CustomFormField(
                icon: AppImages.email,
                hintText: 'قم بادخال البريد الالكتروني',
                keyboardType: TextInputType.emailAddress,
                controller: emailController),
            SizedBox(
              height: MediaQueryHelper.height * .02,
            ),

            // if (state is loginLoaded) {
            CustomButton(
              onPressed: () {
                AppRoutes.pushNamedNavigator(
                    routeName: Routes.emailVerification);
              },
              text: 'تفعيل رقم الجوال',
              background: Theme.of(context)
                  .colorScheme
                  .primary, /*  textColor: textColor */
            ),
          ],
        ),
      )),
    );
  }
}
