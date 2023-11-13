import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_bloc.dart';
import 'package:pick_up/features/auth/data/view_model/bloc/auth_event.dart';
import 'package:pick_up/features/auth/data/view_model/otp_bloc/otp_bloc.dart';
import 'package:pick_up/features/on_boarding/view/widgets/code_verification_field.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with Validations {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   // var bloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black,size: 17.r),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Form(
        key: OTPBloc.instance.formKey,
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
              child: BlocBuilder<OTPBloc, OTPState>(
                builder: (context, state) {
                  return Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'تفعيل البريد الالكتروني',
                        style: TextStyleHelper.title24,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      const Text(
                        'تم ارسال كود التفعيل المكون من 4 ارقام فى رسالة قصيرة على البريد',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .04,
                      ),
                      ///// make it list.generate
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CodeVerificationField(
                              controller: OTPBloc.instance.codeController4,
                            ),
                            CodeVerificationField(
                              controller: OTPBloc.instance.codeController3,
                            ),
                            CodeVerificationField(
                              controller: OTPBloc.instance.codeController2,
                            ),
                            CodeVerificationField(
                              controller: OTPBloc.instance.codeController1,
                            ),
                          ]),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),

                      // if (state is loginLoaded) {
                      CustomButton(
                        width: state is OTPLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        onPressed: () {
                          if (OTPBloc.instance.formKey.currentState!.validate()) {
                            log('valid');
                            log('log ${OTPBloc.instance.codeController1}');
                            log('log ${OTPBloc.instance.codeController1.text}');
                          //  log('log ${OTPBloc.instance.emailController}');
                            log([
                              OTPBloc.instance.codeController1.text,
                              OTPBloc.instance.codeController2.text,
                              OTPBloc.instance.codeController3.text,
                              OTPBloc.instance.codeController4.text,
                            ].join());
                            // _formKey.currentState!.save();
                            //log(name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sending code')),
                            );
                            OTPBloc.instance.add(OTPPost());
                          } else {
                            log('not valid');
                          }
                          log([
                            OTPBloc.instance.codeController1.text,
                            OTPBloc.instance.codeController2.text,
                            OTPBloc.instance.codeController3.text,
                            OTPBloc.instance.codeController4.text,
                          ].join());
                          //log('type= ${bloc.type}');
                        },
                        child: state is OTPLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'تفعيل البريد الالكتروني',
                                style: TextStyleHelper.subtitle19.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                        /*  textColor: textColor */
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      state is OTPError
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
