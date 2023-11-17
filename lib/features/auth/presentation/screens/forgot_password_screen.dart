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

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> with Validations {
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
          child: Padding(
        padding: EdgeInsets.all(24.0.r),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'نسيت كلمة المرور',
                        style: TextStyleHelper.title24,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                          validator: isValidPhone,
                          icon: AppImages.phone,
                          hintText: 'قم بادخال رقم الجوال',
                          keyboardType: TextInputType.phone,
                          controller: bloc.phoneController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomButton(
                        width: state is AuthLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log('valid');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم ارسال الكود')),
                            );
                            bloc.add(ForgetPasswordClick());
                          } else {
                            log('not valid');
                          }

                          //log('type= ${bloc.type}');
                        },
                        child: state is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'تفعيل رقم الجوال',
                                style: TextStyleHelper.subtitle19.copyWith(
                                  color: Colors.white,
                                ),
                              ), /*  textColor: textColor */
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      state is AuthError
                          ? Text(
                              'هناك خطا في البيانات',
                              style: TextStyleHelper.subtitle19,
                            )
                          : const SizedBox()
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
