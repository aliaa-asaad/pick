import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController = TextEditingController();
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
              'كلمة مرور جديدة',
              style: TextStyleHelper.title25,
            ),
            SizedBox(
              height: MediaQueryHelper.height * .02,
            ),

            CustomFormField(
                icon: AppImages.password,
                hintText: 'قم بادخال كلمة المرور الجديدة',
                keyboardType: TextInputType.visiblePassword,
                controller: newPasswordController),
            SizedBox(
              height: MediaQueryHelper.height * .02,
            ),
             CustomFormField(
                icon: AppImages.password,
                hintText: 'تأكيد كلمة المرور',
                keyboardType: TextInputType.visiblePassword,
                controller: confirmNewPasswordController),
            SizedBox(
              height: MediaQueryHelper.height * .02,
            ),

            // if (state is loginLoaded) {
            CustomButton(
              onPressed: () {
               
              },
              text: 'تأكيد كلمة المرور',
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