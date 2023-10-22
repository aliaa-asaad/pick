import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/utilities/text_style.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Path customPath = Path()
      ..moveTo(20, 20)
      ..lineTo(100, 20)
      /* ..lineTo(20, 200)
      ..lineTo(100, 100)
      ..lineTo(20, 20) */;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text('طلباتي'),
        titleTextStyle: TextStyleHelper.subtitle20.copyWith(
            color: Theme.of(context).colorScheme.primary, fontFamily: 'Cairo'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(24.0.r),
          child: Column(
            children: [
              DottedBorder(
                
                customPath: (size) => customPath, // PathBuilder
                color: Theme.of(context).colorScheme.primary,
                dashPattern: const [8, 4],
                strokeWidth: 2,
                child: SizedBox()
              )
            ],
          ),
        ),
      ),
    );
  }
}
