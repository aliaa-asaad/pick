import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/auth/register/data/view_model/bloc/register_bloc.dart';
import 'package:pick_up/features/on_boarding/view/widgets/code_verification_field.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>
    with Validations {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<RegisterBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
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
              child: BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  if (state is RegisterError) {
                    return const Center(child: Text('Error'));
                  }
                  return Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'تفعيل البريد الالكتروني',
                        style: TextStyleHelper.title25,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      const Text(
                        'تم ارسال كود التفعيل المكون من 6 ارقام فى رسالة قصيرة على البريد',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .04,
                      ),
                      Row(
                        children:[CodeVerificationField(
                            controller: bloc.codeController1,
                            validator: isValidCode,
                          ),
                          CodeVerificationField(
                            controller: bloc.codeController2,
                            validator: isValidCode,
                          ),CodeVerificationField(
                            controller: bloc.codeController3,
                            validator: isValidCode,
                          ),CodeVerificationField(
                            controller: bloc.codeController4,
                            validator: isValidCode,
                          ),CodeVerificationField(
                            controller: bloc.codeController5,
                            validator: isValidCode,
                          ),CodeVerificationField(
                            controller: bloc.codeController6,
                            validator: isValidCode,
                          ),]
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),

                      // if (state is loginLoaded) {
                      CustomButton(
                        width: state is RegisterLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            log('valid');
                            log('log ${bloc.codeController1}');
                            log('log ${bloc.codeController1.text}');
                            log([
                              bloc.codeController1.text,
                              bloc.codeController2.text,
                              bloc.codeController3.text,
                              bloc.codeController4.text,
                              bloc.codeController5.text,
                              bloc.codeController6.text,
                            ].join());
                            // _formKey.currentState!.save();
                            //log(name);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Sending code')),
                            );
                          } else {
                            log('not valid');
                          }
                          log([
                            bloc.codeController1.text,
                            bloc.codeController2.text,
                            bloc.codeController3.text,
                            bloc.codeController4.text,
                            bloc.codeController5.text,
                            bloc.codeController6.text,
                          ].join());
                          //log('type= ${bloc.type}');

                          // bloc.add(CodeVerificationClick());
                        },
                        child: state is RegisterLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'تفعيل البريد الالكتروني',
                                style: TextStyleHelper.subtitle20.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                        /*  textColor: textColor */
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
