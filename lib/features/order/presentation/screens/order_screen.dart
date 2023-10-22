import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  Path customPath = Path()
        ..moveTo(0, 0)
        ..lineTo(50, 0)
      /* ..lineTo(20, 200)
      ..lineTo(100, 100)
      ..lineTo(20, 20) */
      ;
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
                Icon(Icons.notifications),
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
            Container(
              height: MediaQueryHelper.height * .13,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  icons.length,
                  (index) => Column(
                    children: [
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 26.r,
                            backgroundColor: currentStep > index
                                ? Colors.green
                                : Theme.of(context).colorScheme.primary,
                            child: CircleAvatar(
                              radius: 25.r,
                              backgroundColor: currentStep > index
                                  ? Colors.green
                                  : currentStep == index
                                      ? Theme.of(context).colorScheme.primary
                                      : Colors.white,
                              child: currentStep > index
                                  ? const Icon(Icons.check_circle,
                                      color: Colors.white)
                                  : SvgPicture.asset(
                                      icons[index]['icon'],
                                      color: currentStep == index
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .primary,
                                    ),
                            ),
                          ),
                          index <= icons.length - 2
                              ? Row(
                                  children: List.generate(
                                      4,
                                      (indexContainer) => Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            width: 5,
                                            height: 1,
                                            color: currentStep > index
                                                ? Colors.green
                                                : Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                          )),
                                ) /* DottedBorder(
                                  customPath: (size) =>
                                      customPath, // PathBuilder
                                  color: currentStep > index
                                      ? Colors.green
                                      : Theme.of(context).colorScheme.primary,
                                  dashPattern: const [8, 3],
                                  strokeWidth: 1,
                                  child: const SizedBox()) */
                              : const SizedBox()
                        ],
                      ),
                      Text(
                        icons[index]['title'],
                        style: TextStyle(
                            color: currentStep == index
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
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
