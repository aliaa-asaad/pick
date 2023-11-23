import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/payment/data/view_model/bloc/payment_bloc.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class EGPaymentMethodsScreen extends StatefulWidget {
    final int orderId;
  const EGPaymentMethodsScreen({super.key, required this.orderId});

  @override
  State<EGPaymentMethodsScreen> createState() => _EGPaymentMethodsScreenState();
}

class _EGPaymentMethodsScreenState extends State<EGPaymentMethodsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyOrderBloc.instance.getOrderDetails(orderId: widget.orderId);
  }
  int _selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: IconButton(
            iconSize: 24.0.r,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Platform.isIOS
                ? const Icon(Icons.arrow_back_ios)
                : const Icon(Icons.arrow_back),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'اختيار وسيلة الدفع',
          style: TextStyleHelper.subtitle19.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0.r, 12.0.r, 24.0.r, 24.0.r),
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              if (state is PaymentLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PaymentError) {
                return Center(
                  child: Text('هناك خطا ما'),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 8.0, // horizontal spacing between the children
                      runSpacing: 12.0, // vertical spacing between the lines
                      children: List.generate(
                        PaymentBloc.instance.egPaymentMethods.length,
                        (index) => InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                              PaymentBloc.instance.paymentMethod = index;
                            });
                            log('paymentMethod: ${PaymentBloc.instance.paymentMethod}');
                          },
                          child: Container(
                            width: 105.0,
                            height: 80.0,
                            padding: EdgeInsets.all(8.0.r),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.0.r),
                                border: Border.all(
                                  color: _selectedIndex == index
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.white,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ]),
                            child: Image.network(PaymentBloc
                                .instance.egPaymentMethods[index].logo!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (PaymentBloc.instance.isValidPaymentMethod()) {
                          log('valid');
                          /*  OrderBloc.instance.viewCounter(back: false); */

                          PaymentBloc.instance.add(PostEGPaymentClick());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('حفظ البيانات')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'الرجاء اختيار كل البيانات المطلوبة ')),
                          );
                        }
                      },
                      width: state is PaymentLoading
                          ? MediaQueryHelper.width * .13
                          : MediaQueryHelper.width,
                      child: state is PaymentLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'متابعة',
                              style: TextStyleHelper.subtitle19.copyWith(
                                color: Colors.white,
                              ),
                            ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
