import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_order_app_bar.dart';
import 'package:pick_up/features/my_order/presentation/widgets/client_info.dart';
import 'package:pick_up/features/my_order/presentation/widgets/driver_location_details.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverOrderStatusScreen extends StatefulWidget {
  const DriverOrderStatusScreen({super.key});

  @override
  State<DriverOrderStatusScreen> createState() =>
      _DriverOrderStatusScreenState();
}

class _DriverOrderStatusScreenState extends State<DriverOrderStatusScreen> {
  Path customPath = Path()
    ..moveTo(-60.w, 0.w)
    ..lineTo(0.w, 0.w);
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> icons = [
      {
        'icon': AppImages.orderStatusIcon1,
        'icon_body': AppImages.orderStatusIconBody12,
        'title': 'فى الطريق',
      },
      {
        'icon': AppImages.orderStatusIcon2,
        'icon_body': AppImages.orderStatusIconBody12,
        'title': 'يتم الاستلام',
      },
      {
        'icon': AppImages.orderStatusIcon3,
        'icon_body': AppImages.orderStatusIconBody3,
        'title': 'تم التوصيل',
      },
      {
        'icon': AppImages.orderStatusIcon4,
        'icon_body': AppImages.orderStatusIconBody4,
        'title': 'الدفع',
      }
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'طلب رقم 1233',
          style: TextStyleHelper.subtitle18
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
              // OrderBloc.instance.currentStep--;
            });
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: currentStep < 0
          ? const SizedBox()
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    // physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        CustomOrderAppBar(
                          icons: icons,
                          currentStep: currentStep,
                          isDriver: true,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 36.0.h),
                              child:
                                  Image.asset(icons[currentStep]['icon_body']),
                            ),
                            Container(
                              height: MediaQueryHelper.height * .42,
                              width: MediaQueryHelper.width,
                              padding:
                                  EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    spreadRadius: 0.5,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, -3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20.r),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQueryHelper.width * .13,
                                    height: MediaQueryHelper.height * .005,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                  ),
                                  SizedBox(
                                    height: MediaQueryHelper.height * .03,
                                  ),
                                  const ClientInfo(),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                  const DriverLocationDetails(),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 1,
                                  ),
                                  CustomButton(
                                    onPressed: () {},
                                    text: 'وصلت لموقع الاستلام',
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
