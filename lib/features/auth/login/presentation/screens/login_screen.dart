import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/login/data/view_model/bloc/login_bloc.dart';
import 'package:pick_up/features/auth/login/data/view_model/bloc/login_event.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class LoginScreen extends StatefulWidget  {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>with Validations {final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        elevation: 0.0,
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
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginError) {
                  return const Center(child: Text('Error'));
                } else if (state is LoginLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'تسجيل دخول',
                      style: TextStyleHelper.title25,
                    ),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    const Text(
                        'قم بادخال رقم الجوال وكلمة السر لاستكمال عملية التسجيل'),
                    SizedBox(
                      height: MediaQueryHelper.height * .04,
                    ),
                    CustomFormField(
                      validator: isValidPhone,
                        icon: AppImages.phone,
                        hintText: 'ادخل رقم الجوال',
                        keyboardType: TextInputType.phone,
                        controller: bloc.phoneController),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    CustomFormField(
                      validator: isValidPassword,
                        icon: AppImages.password,
                        hintText: 'ادخل كلمة السر',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        controller: bloc.password),
                    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          AppRoutes.pushNamedNavigator(
                              routeName: Routes.forgetPassword);
                        },
                        child: Text(
                          'هل نسيت كلمة المرور؟',
                          style: TextStyleHelper.body16.copyWith(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    // if (state is loginLoaded) {
                    CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                            // _formKey.currentState!.save();
                            //log(name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          } else {
                            log('not valid');
                          }
                         // log('type= ${bloc.type}');
                        bloc.add(LoginClick());
                      },
                      text: 'متابعة',
                      background: Theme.of(context)
                          .colorScheme
                          .primary, /*  textColor: textColor */
                    ),
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
