import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/confirm_additional_services.dart';
import 'package:pick_up/app_widgets/confirm_content.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_event.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/order/presentation/widgets/confirm_car_card.dart';
import 'package:pick_up/features/order/presentation/widgets/order_location.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyOrderBloc.instance.getOrderDetails(orderId: widget.orderId);
    log('order data is ${MyOrderBloc.instance.orderDetailsModel.toString()}');
    log('order description is ${MyOrderBloc.instance.orderDetailsModel.shipmentDescription.toString()}');
  }

  @override
  void dispose() {
    super.dispose();
    MyOrderBloc.instance.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    // MyOrderBloc.instance.getOrderDetails(orderId: widget.orderId);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'تفاصيل طلب رقم ${widget.orderId}',
          style: TextStyleHelper.body15.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<MyOrderBloc, MyOrderState>(
          builder: (context, state) {
            if (state is MyOrderLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MyOrderError) {
              return const Center(
                child: Text('error'),
              );
            } else if (state is MyOrderLoaded) {
              List<Map<String, dynamic>> content = [
                {'title': 'نوع الشاحنة', 'content': 'نوع الشحنة'},
                {
                  'title': 'نوع الشحنة',
                  'content': MyOrderBloc
                      .instance.orderDetailsModel.shipmentType /* ?? 'اثاث' */
                },
                {
                  'title': 'مواصفات شحنتك',
                  'content': MyOrderBloc.instance.orderDetailsModel
                      .shipmentDescription /* ?? 'اثاث' */
                },
              ];
              List<Map<String, dynamic>> additionalService = [
                {
                  'title': 'خدمات التحميل والتنزيل',
                  'type': /* MyOrderCubit.instance.orderDetailsModel. */
                      'غير متوفر',
                },
                {
                  'title': 'المصعد الكهربائي',
                  'type': MyOrderBloc
                      .instance.orderDetailsModel.elevatorAvilabel /* 0 */,
                },
                {
                  'title': 'عامل إضافي',
                  'type': MyOrderBloc
                      .instance.orderDetailsModel.extramanAvilabel /* 0 */,
                },
              ];

              return SingleChildScrollView(
                padding: EdgeInsets.all(24.r),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    OrderLocation(
                        isDetails: true,
                        title: 'موقع استلام البضائع',
                        location: MyOrderBloc
                            .instance.orderDetailsModel.pickupLocation!),
                    OrderLocation(
                        isDetails: true,
                        title: 'موقع توصيل البضائع',
                        location: MyOrderBloc
                            .instance.orderDetailsModel.deliveryLocation!),
                    SizedBox(
                      height: MediaQueryHelper.height * .04,
                    ),
                    Column(
                      children: List.generate(
                        content.length,
                        (index) => ConfirmContent(
                            isDetails: true,
                            contentList: content,
                            title: content[index]['title'],
                            content: content[index]['content'],
                            card: index == 0
                                ? ConfirmCarCard(
                                    image: OrderBloc.instance.carCardData[
                                        int.parse(MyOrderBloc
                                            .instance
                                            .orderDetailsModel
                                            .carType!)]['image'],
                                    title: OrderBloc.instance.carCardData[
                                        int.parse(MyOrderBloc
                                            .instance
                                            .orderDetailsModel
                                            .carType!)]['title'],
                                    length: OrderBloc.instance.carCardData[
                                        int.parse(MyOrderBloc
                                            .instance
                                            .orderDetailsModel
                                            .carType!)]['length'],
                                    weight: OrderBloc.instance.carCardData[
                                        int.parse(MyOrderBloc
                                            .instance
                                            .orderDetailsModel
                                            .carType!)]['weight'],
                                  )
                                : null),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        additionalService.length,
                        (index) => ConfirmAdditionalServices(
                            isDetails: true,
                            isAvailable:
                                additionalService[index]['type'] == true
                                    ? 0
                                    : 1,
                            title: additionalService[index]['title'],
                            type: additionalService[index]['type'] == true
                                ? 'متوفر'
                                : 'غير متوفر'),
                      ),
                    ),
                    SharedHandler.instance!.getData(
                                key: SharedKeys().userType,
                                valueType: ValueType.int) ==
                            0
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'السعر: ',
                                style: TextStyleHelper.subtitle17.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff001833)),
                              ),
                              Text.rich(
                                TextSpan(
                                  text:
                                      '${MyOrderBloc.instance.orderDetailsModel.price} ',
                                  style: TextStyleHelper.subtitle17.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff001833)),
                                  children: [
                                    TextSpan(
                                      text: ' ريال',
                                      style: TextStyleHelper.button13.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: const Color(0xff001833)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    SharedHandler.instance!.getData(
                                key: SharedKeys().userType,
                                valueType: ValueType.int) ==
                            1
                        ? MyOrderBloc.instance.tabBarCurrentIndex == 1
                            ? const SizedBox()
                            : CustomButton(
                                onPressed: () {
                                  if (SharedHandler.instance!.getData(
                                          key: SharedKeys().userType,
                                          valueType: ValueType.int) ==
                                      1) {
                                    if (MyOrderBloc
                                            .instance.tabBarCurrentIndex ==
                                        0) {
                                      setState(() {
                                        MyOrderBloc.instance.orderId =
                                            widget.orderId;
                                      });

                                      MyOrderBloc.instance
                                          .add(OrderStatusClick());
                                      Navigator.pop(context);
                                    } else if (MyOrderBloc
                                            .instance.tabBarCurrentIndex ==
                                        2) {
                                      AppRoutes.pushNamedNavigator(
                                          routeName: Routes.driverOrderStatus);

                                      MyOrderBloc.instance
                                          .add(OrderStatusClick());
                                    }

                                    /* AppRoutes.pushNamedNa
                                vigator(
                              routeName: Routes.driverOrderStatus);

                          MyOrderBloc.instance.add(OrderStatusClick()); */
                                    /* MyOrderBloc.instance
                                        .add(OrderStatusClick()); */
                                  }
                                },
                                text: 'تقديم',
                              )
                        : const SizedBox()
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('هناك خطا ما'),
              );
            }
          },
        ),
      ),
    );
  }
}
