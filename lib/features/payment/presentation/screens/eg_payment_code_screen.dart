import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/payment/data/view_model/bloc/payment_bloc.dart';
import 'package:pick_up/utilities/text_style.dart';

class EGPAymentCodeScreen extends StatefulWidget {
  const EGPAymentCodeScreen({super.key});

  @override
  State<EGPAymentCodeScreen> createState() => _EGPAymentCodeScreenState();
}

class _EGPAymentCodeScreenState extends State<EGPAymentCodeScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    PaymentBloc.instance. code = '';
    PaymentBloc.instance. expiredDate = 'لا يوجد تاريخ انتهاء';
    PaymentBloc.instance. qrCode = 'لا يوجد QR code';
  }

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
          'الدفع عن طريق الكود',
          style: TextStyleHelper.subtitle19.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            DateTime date =
                PaymentBloc.instance.expiredDate != 'لا يوجد تاريخ انتهاء'
                    ? DateTime.parse(PaymentBloc.instance.expiredDate)
                    : DateTime(0);
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(24.0.r, 12.0.r, 24.0.r, 24.0.r),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'كود الدفع',
                      style: TextStyleHelper.body15,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(PaymentBloc.instance.code),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'تاريخ الانتهاء',
                      style: TextStyleHelper.body15,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(PaymentBloc.instance.expiredDate !=
                              'لا يوجد تاريخ انتهاء'
                          ? '${date.day}/${date.month}/${date.year}'
                          : PaymentBloc.instance.expiredDate),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'QR code',
                      style: TextStyleHelper.body15,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      //  height: 40,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(PaymentBloc.instance.qrCode),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(164, 40)),
                          child: const Text('اخذ صورة للشاشة'),
                        ),
                        ElevatedButton(
                          onPressed: () async {},
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(164, 40)),
                          child: const Text('نسخ الكود'),
                        )
                      ],
                    )
                  ]),
            );
          },
        ),
      ),
    );
  }
}
