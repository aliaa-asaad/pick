import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> with Validations {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black,size: 17.r),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Padding(
            padding: EdgeInsets.all(24.0.r),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'كلمة مرور جديدة',
                        style: TextStyleHelper.title24,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),

                      CustomFormField(
                          icon: AppImages.password,
                          validator: isValidPassword,
                          hintText: 'قم بادخال كلمة المرور الجديدة',
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          controller: bloc.passwordController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                        icon: AppImages.password,
                        hintText: 'تأكيد كلمة المرور',
                        keyboardType: TextInputType.visiblePassword,
                        controller: bloc.confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "الرجاء ادخال كلمة المرور التأكيدية";
                          } else if (value != bloc.passwordController.text) {
                            return "كلمة المرور غير متطابقة";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),

                      // if (state is loginLoaded) {
                      CustomButton(
                        width: state is AuthLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // _formKey.currentState!.save();
                            //log(name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم حفظ البيانات')),
                            );
                            bloc.add(NewPasswordClick());
                          } else {
                            log('not valid');
                          }
                          log('type= ${bloc.type}');
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'تأكيد كلمة المرور',
                                style: TextStyleHelper.subtitle19.copyWith(
                                  color: Colors.white,
                                ),
                              ), /*  textColor: textColor */
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      )),
    );
  }
}
