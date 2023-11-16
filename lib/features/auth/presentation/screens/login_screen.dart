import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/features/auth/data/view_model/login_bloc/login_bloc.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Validations {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black,size: 17.r),
        elevation: 0.0,
      ),
      body: SafeArea(
          child: Form(
        key: LoginBloc.instance.formKey,
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
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'تسجيل دخول',
                      style: TextStyleHelper.title24,
                    ),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    Text(
                      'قم بادخال رقم الجوال وكلمة السر لاستكمال عملية التسجيل',
                      textAlign: TextAlign.center,
                      style: TextStyleHelper.button13
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: MediaQueryHelper.height * .04,
                    ),
                    CustomFormField(
                        validator: isValidPhone,
                        icon: AppImages.phone,
                        hintText: 'ادخل رقم الجوال',
                        keyboardType: TextInputType.phone,
                        controller: LoginBloc.instance.phoneNumberController),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    CustomFormField(
                        validator: isValidPassword,
                        icon: AppImages.password,
                        hintText: 'ادخل كلمة السر',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        controller: LoginBloc.instance.passwordController),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          AuthBloc.instance.isForgetPassword = true;
                          AppRoutes.pushNamedNavigator(
                              routeName: Routes.forgetPassword);
                        },
                        child: Text(
                          'هل نسيت كلمة المرور؟',
                          style: TextStyleHelper.body15.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    // if (state is loginLoaded) {
                    CustomButton(
                      width: state is LoginLoading
                          ? MediaQueryHelper.width * .13
                          : MediaQueryHelper.width,
                      child: state is LoginLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'متابعة',
                              style: TextStyleHelper.subtitle19.copyWith(
                                color: Colors.white,
                              ),
                            ),
                      onPressed: () {
                        if (LoginBloc.instance.formKey.currentState!
                            .validate()) {
                          // _formKey.currentState!.save();
                          //log(name);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('تم حفظ البيانات')),
                          );
                          LoginBloc.instance.add(LoginPost());
                          //BlocProvider.of<NotificationCubit>(context).getPusherBeams();
                        } else {
                          log('not valid');
                        }
                        // log('type= ${bloc.type}');
                      },
                      /*  textColor: textColor */
                    ),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    state is LoginError
                        ? Text(
                            'هناك خطا في البيانات',
                            style: TextStyleHelper.subtitle19,
                          )
                        : const SizedBox()
                  ],
                );

                //return const Text('');
              }),
            ),
          ),
        ),
      )),
    );
  }
}
