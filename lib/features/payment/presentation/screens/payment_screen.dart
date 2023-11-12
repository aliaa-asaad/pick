import 'package:flutter/material.dart';
import 'package:pick_up/utilities/text_style.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('الدفع'),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: TextStyleHelper.subtitle19.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontFamily:
                  Theme.of(context).appBarTheme.titleTextStyle!.fontFamily),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      /* body: 
      ), */
    );
  }
}
