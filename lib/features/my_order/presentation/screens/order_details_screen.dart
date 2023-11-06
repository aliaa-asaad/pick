import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/my_order/data/view_model/cubit/my_order_cubit.dart';
import 'package:pick_up/app_widgets/confirm_additional_services.dart';
import 'package:pick_up/features/order/presentation/widgets/confirm_car_card.dart';
import 'package:pick_up/app_widgets/confirm_content.dart';
import 'package:pick_up/features/order/presentation/widgets/order_location.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    MyOrderCubit.instance.getOrderDetails(orderId: orderId);
    List<Map<String, dynamic>> content = [
      {'title': 'نوع الشاحنة', 'content': 'نوع الشحنة'},
      {
        'title': 'نوع الشحنة',
        'content': MyOrderCubit.instance.orderDetailsModel.shipmentType??'اثاث'
      },
      {
        'title': 'مواصفات شحنتك',
        'content': MyOrderCubit.instance.orderDetailsModel.shipmentDescription??'اثاث'
      },
    ];
    List<Map<String, dynamic>> additionalService = [
      {
        'title': 'خدمات التحميل والتنزيل',
        'type': /* MyOrderCubit.instance.orderDetailsModel. */ 'غير متوفر',
      },
      {
        'title': 'المصعد الكهربائي',
        'type': MyOrderCubit.instance.orderDetailsModel.elevatorAvilabel,
      },
      {
        'title': 'عامل إضافي',
        'type': MyOrderCubit.instance.orderDetailsModel.extramanAvilabel,
      },
    ];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQueryHelper.height * .1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        title: Text(
          'تفاصيل طلب رقم $orderId',
          style: TextStyleHelper.body16.copyWith(
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
        child: BlocBuilder<MyOrderCubit, MyOrderState>(
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
              return SingleChildScrollView(
                padding: EdgeInsets.all(24.r),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    OrderLocation(
                        isDetails: true,
                        title: 'موقع استلام البضائع',
                        location: MyOrderCubit
                            .instance.orderDetailsModel.pickupLocation!),
                    OrderLocation(
                        isDetails: true,
                        title: 'موقع توصيل البضائع',
                        location: MyOrderCubit
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
                                    image: AppImages.car1,
                                    title: MyOrderCubit
                                        .instance.orderDetailsModel.carType!,
                                    length: 'طول الشاحنة',
                                    weight: 'وزن الشاحنة',
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
                    CustomButton(
                      onPressed: () {
                        SharedHandler.instance!.getData(
                                    key: SharedKeys().userType,
                                    valueType: ValueType.int) ==
                                0
                            ? null
                            : AppRoutes.pushNamedNavigator(
                                routeName: Routes.driverOrderStatus);
                      },
                      text: 'تقديم',
                    )
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text('null'),
              );
            }
          },
        ),
      ),
    );
  }
}
