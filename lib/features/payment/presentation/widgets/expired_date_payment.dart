// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ExpiredDatePayment extends StatefulWidget {
  final BorderSide? borderSide;
  const ExpiredDatePayment({
    Key? key,
    this.borderSide,
  }) : super(key: key);

  @override
  State<ExpiredDatePayment> createState() => _ExpiredDatePaymentState();
}

class _ExpiredDatePaymentState extends State<ExpiredDatePayment> {
  DateTime? endDate;

  endDateMethod() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001, 1, 1),
      lastDate: DateTime(2095, 12, 30),
    ).then((value) {
      setState(() {
        endDate = value;
        OrderBloc.instance.cardExpiredDateController.text = endDate.toString();
        log('end :${endDate.toString()}');
      });
      if (value == null) {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          side: BorderSide(color: Colors.grey.shade300),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              side: widget.borderSide!,
              borderRadius: BorderRadius.circular(16.r)),
          minimumSize: Size(
              MediaQueryHelper.width * .42, MediaQueryHelper.height * .06)),
      onPressed: () async {
        await endDateMethod();
        log('end date: ${endDate.toString()}');
      },
      child: endDate == null
          ? Text('تاريخ الانتهاء',
              style: TextStyleHelper.button13
                  .copyWith(color: Colors.grey, fontWeight: FontWeight.normal))
          : Text('${endDate!.day}/${endDate!.month}/${endDate!.year}',
              style: TextStyleHelper.button13.copyWith(
                  color: Colors.black, fontWeight: FontWeight.normal)),
    );
  }
}
