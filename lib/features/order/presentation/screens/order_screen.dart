import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/app_widgets/custom_order_app_bar.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/order/presentation/screens/order_confirm_screen.dart';
import 'package:pick_up/features/order/presentation/screens/order_data_screen.dart';
import 'package:pick_up/features/order/presentation/screens/order_image_screen.dart';
import 'package:pick_up/features/order/presentation/screens/order_location_screen.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> icons = [
      {
        'icon': AppImages.orderIcon1,
        'title': 'بيانات الطلب',
        'body': const OrderDataScreen()
      },
      {
        'icon': AppImages.orderIcon2,
        'title': 'حدد الموقع',
        'body': const OrderLocationScreen()
      },
      {
        'icon': AppImages.orderIcon3,
        'title': 'صور الشحنة',
        'body': const OrderImageScreen(),
      },
      {
        'icon': AppImages.orderIcon4,
        'title': 'تاكيد الطلب',
        'body': const OrderConfirmScreen()
      }
    ];

    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderCounter) {
          currentStep = OrderBloc.instance.currentStep;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.primary),
              actions: [
                Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: Icon(
                    Icons.notifications,
                    size: MediaQueryHelper.height * .025,
                  ),
                ),
              ],
              title: Text(
                'إنشاء طلب جديد',
                style: TextStyleHelper.subtitle17
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              toolbarHeight: MediaQueryHelper.height * .07,
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                
                onPressed: () async {
                  if (currentStep == 0) {
                    Navigator.pop(context);
                  }
                  setState(() {
                    currentStep--;
                    OrderBloc.instance.currentStep--;
                  });
                },
                icon: Platform.isIOS
                    ? Icon(Icons.arrow_back_ios,size: MediaQueryHelper.height * .025 ,)
                    :  Icon(Icons.arrow_back,size: MediaQueryHelper.height * .025),
              )),
          body: Column(children: [
            CustomOrderAppBar(
              icons: icons,
              currentStep: currentStep,
            ),
            Expanded(
                child: currentStep < 0
                    ? const SizedBox()
                    : icons[currentStep]['body'])
          ]),
        );
      },
    );
  }
}
