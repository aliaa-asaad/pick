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
              actions: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.notifications),
                ),
              ],
              title: Text(
                'إنشاء طلب جديد',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
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
                icon: const Icon(Icons.arrow_back),
              )),
          body: Column(children: [
            CustomOrderAppBar(
                icons: icons, currentStep: currentStep, ),
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

