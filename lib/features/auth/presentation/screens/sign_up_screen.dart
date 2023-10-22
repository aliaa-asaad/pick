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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen> with Validations {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<AuthBloc>(context);
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
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                 

                  return Column(
                    children: [
                      Text(
                        'انشاء حساب',
                        style: TextStyleHelper.title25,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      const Text('ادخل البيانات لاستكمال التسجيل'),
                      SizedBox(
                        height: MediaQueryHelper.height * .04,
                      ),
                      CustomFormField(
                          validator: isValidName,
                          icon: AppImages.name,
                          hintText: 'قم بادخال الاسم',
                          keyboardType: TextInputType.name,
                          controller: bloc.fullNameController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                          validator: isValidPhone,
                          icon: AppImages.phone,
                          hintText: 'قم بادخال رقم الهاتف ',
                          keyboardType: TextInputType.phone,
                          controller: bloc.phoneNumberController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                        validator: isValidEmail,
                        icon: AppImages.email,
                        hintText: 'قم بادخال البريد الالكتروني ',
                        keyboardType: TextInputType.emailAddress,
                        controller: bloc.emailController,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                        validator: isValidPassword,
                        icon: AppImages.password,
                        hintText: 'قم بادخال كلمة المرور ',
                        keyboardType: TextInputType.visiblePassword,
                        isPassword: true,
                        controller: bloc.passwordController,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "الرجاء ادخال كلمة المرور التأكيدية";
                            } else if (value != bloc.passwordController.text) {
                              return "كلمة المرور غير متطابقة";
                            }
                            return null;
                          },
                          icon: AppImages.password,
                          hintText: 'تأكيد كلمة المرور',
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                          controller: bloc.confirmPasswordController),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      CustomButton(
                        width: state is AuthLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // _formKey.currentState!.save();
                            //log(name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            ); 
                            bloc.add(RegisterClick());
                          } else {
                            log('not valid');
                          }
                          log('type= ${bloc.type}');

                         
                        },
                        child: state is AuthLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'تسجيل',
                                style: TextStyleHelper.subtitle20.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                        /*  textColor: textColor */
                      ),
                       SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    state is AuthError
                        ? Text(
                            'هناك خطا في البيانات',
                            style: TextStyleHelper.subtitle20,
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
