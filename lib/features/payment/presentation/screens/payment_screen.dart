import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/payment/presentation/widgets/cvv_form_field.dart';
import 'package:pick_up/features/payment/presentation/widgets/expired_date_payment.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> with Validations {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدفع'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 182, 98, 98)),
        titleTextStyle: TextStyleHelper.subtitle19.copyWith(
            color: Theme.of(context).colorScheme.primary,
            fontFamily:
                Theme.of(context).appBarTheme.titleTextStyle!.fontFamily),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(24.0.r),
              child: InkWell(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Form(
                  key: OrderBloc.instance.formKey,
                  child: Column(
                    children: [
                      CustomFormField(
                          hintText: 'اسم الكارت',
                          keyboardType: TextInputType.name,
                          validator: isValidName,
                          controller: OrderBloc.instance.cardNameController),
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      CustomFormField(
                          hintText: 'رقم الكارت',
                          validator: isValidCardNumber,
                          keyboardType: TextInputType.name,
                          controller: OrderBloc.instance.cardNumberController),
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ExpiredDatePayment(
                              borderSide: state is OrderError
                                  ? const BorderSide(
                                      color: Colors.red, width: 1)
                                  : BorderSide.none),
                          const CvvFormField()
                        ],
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      CustomFormField(
                          hintText: 'برومو كود',
                          validator: isValidContent,
                          keyboardType: TextInputType.name,
                          controller: OrderBloc.instance.cardNumberController),
                      SizedBox(
                        height: MediaQueryHelper.height * .01,
                      ),
                      CustomButton(
                        width: state is OrderLoading
                            ? MediaQueryHelper.width * .13
                            : MediaQueryHelper.width,
                        child: state is OrderLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'ارسال',
                                style: TextStyleHelper.subtitle19.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                        onPressed: () {
                          if (OrderBloc.instance.formKey.currentState!
                              .validate()) {
                            if (OrderBloc.instance.isValidImages()) {
                              log('valid');
                              //OrderBloc.instance.viewCounter(back: false);
                              OrderBloc.instance.add(OrderImagesClick());
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('حفظ البيانات')),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'الرجاء ادخال كل البيانات المطلوبة ')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'الرجاء ادخال كل البيانات المطلوبة ')),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQueryHelper.height * .02,
                      ),
                      state is OrderError
                          ? Text(
                              'هناك خطا في البيانات',
                              style: TextStyleHelper.subtitle19,
                            )
                          : const SizedBox()
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
