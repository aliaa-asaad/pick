import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_order_app_bar.dart';
import 'package:pick_up/features/my_order/data/model/all_orders_model.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_event.dart';
import 'package:pick_up/features/my_order/presentation/widgets/driver_info.dart';
import 'package:pick_up/features/my_order/presentation/widgets/driver_location_details.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverOrderStatusScreen extends StatefulWidget {
  final Orders orderModel;
  const DriverOrderStatusScreen({super.key, required this.orderModel});

  @override
  State<DriverOrderStatusScreen> createState() =>
      _DriverOrderStatusScreenState();
}

class _DriverOrderStatusScreenState extends State<DriverOrderStatusScreen> {
  Path customPath = Path()
    ..moveTo(-60.w, 0.w)
    ..lineTo(0.w, 0.w);
  /* int currentStep = MyOrderBloc.instance.orderStatus.status == 3
      ? 0
      : MyOrderBloc.instance.orderStatus.status == 4
          ? 1
          : MyOrderBloc.instance.orderStatus.status == 5
              ? 2
              : MyOrderBloc.instance.orderStatus.status == 6
                  ? 3
                  : 4; */

  @override
  void dispose() {
    super.dispose();
    MyOrderBloc.instance.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    MyOrderBloc.instance.orderId = widget.orderModel.id;
    List<Map<String, dynamic>> icons = [
      {
        'icon': AppImages.orderStatusIcon1,
        'icon_body': AppImages.orderStatusIconBody12,
        'title': 'فى الطريق',
        'button_text': 'وصلت لموقع الاستلام'
      },
      {
        'icon': AppImages.orderStatusIcon2,
        'icon_body': AppImages.orderStatusIconBody12,
        'title': 'يتم الاستلام',
        'button_text': 'تم الاستلام'
      },
      {
        'icon': AppImages.orderStatusIcon3,
        'icon_body': AppImages.orderStatusIconBody3,
        'title': 'تم التوصيل',
        'button_text': 'تم التوصيل بنجاح'
      },
      {
        'icon': AppImages.orderStatusIcon4,
        'icon_body': AppImages.orderStatusIconBody4,
        'title': 'الدفع',
        'button_text': 'تحديث الحالة الى مكتمل'
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'طلب رقم ${widget.orderModel.id}',
          style: TextStyleHelper.subtitle17
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            /* if (MyOrderBloc.instance.currentStep == 0) { */
            Navigator.pop(context);
            //}
            /* setState(() {
              currentStep--;
              // OrderBloc.instance.currentStep--;
            }); */
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: /* /* MyOrderBloc.instance. */ currentStep < 0
          ? const SizedBox()
          : */
          BlocBuilder<MyOrderBloc, MyOrderState>(builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                // physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    CustomOrderAppBar(
                      icons: icons,
                      currentStep: /*  MyOrderBloc.instance
                                . */
                          MyOrderBloc.instance
                              .currentStep! /* MyOrderBloc.instance.orderDetailsModel.orderStatus! */,
                      isDriver: true,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 36.0.h),
                          child: Image.asset(icons[
                              /* MyOrderBloc.instance. */ MyOrderBloc
                                  .instance.currentStep!]['icon_body']),
                        ),
                        Container(
                          height: MediaQueryHelper.height * .42,
                          width: MediaQueryHelper.width,
                          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 12.h),
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
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                              SizedBox(
                                height: MediaQueryHelper.height * .03,
                              ),
                              DriverInfo(
                                  driverName:
                                      widget.orderModel.driverFullName!),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                              DriverLocationDetails(
                                deliveryLocation:
                                    widget.orderModel.deleviryLocation!,
                                pickupLocation:
                                    widget.orderModel.pickupLocation!,
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                              CustomButton(
                                width: state is MyOrderLoading
                                    ? MediaQueryHelper.width * .13
                                    : MediaQueryHelper.width,
                                onPressed: () {
                                  if (/* MyOrderBloc.instance. */ MyOrderBloc
                                          .instance.currentStep! ==
                                      icons.length - 1) {
                                    MyOrderBloc.instance
                                        .add(OrderStatusClick());
                                    AppRoutes.pushNamedNavigator(
                                        routeName: Routes.driverNavBar);
                                  } else {
                                    setState(() {
                                      MyOrderBloc.instance
                                          .add(OrderStatusClick());

                                      // OrderBloc.instance.currentStep++;
                                    });
                                  }
                                },
                                child: state is MyOrderLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : Text(
                                        icons[
                                            /* MyOrderBloc.instance
                                                  . */
                                            MyOrderBloc.instance
                                                .currentStep!]['button_text'],
                                        style:
                                            TextStyleHelper.subtitle19.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
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
        );
      }),
    );
  }
}
