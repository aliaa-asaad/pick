import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/my_order/presentation/widgets/custom_indicator.dart';
import 'package:pick_up/features/my_order/presentation/widgets/default_tab_bar.dart';
import 'package:pick_up/features/my_order/presentation/widgets/order_status_card.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DriverOrderScreen extends StatefulWidget {
  const DriverOrderScreen({super.key});

  @override
  State<DriverOrderScreen> createState() => _DriverOrderScreenState();
}

class _DriverOrderScreenState extends State<DriverOrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    MyOrderBloc.instance.getAllOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> content = [
      'طلبات جديدة',
      'قيد الانتظار',
      'جاري تنفيذها',
    ];
    return BlocBuilder<MyOrderBloc, MyOrderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            leading: IconButton(iconSize: MediaQueryHelper.height*.024,
              onPressed: () {
                AppRoutes.pushNamedNavigator(routeName: Routes.notification);
              },
              icon: SvgPicture.asset(
                AppImages.notificationIcon,
                color: Theme.of(context).colorScheme.primary,
                
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text('طلباتي'),
            titleTextStyle: TextStyleHelper.subtitle19.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontFamily:
                    Theme.of(context).appBarTheme.titleTextStyle!.fontFamily),
          ),
          body: SafeArea(
            child: Column(
              children: [
                DefaultTabBar(
                  tabController: _tabController,
                  content: content,
                ),
                Expanded(
                  child: state is MyOrderLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is MyOrderError
                          ? const Center(child: Text('حدث خطأ ما'))
                          : MyOrderBloc.instance.allOrdersModel.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.all(24.r),
                                  itemCount: MyOrderBloc
                                      .instance.allOrdersModel.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        if (MyOrderBloc
                                                .instance.tabBarCurrentIndex ==
                                            2) {
                                          // Navigator.pop(context);
                                          setState(() {
                                            /*  MyOrderBloc.instance.currentStep =
                                                MyOrderBloc
                                                        .instance
                                                        .allOrdersModel[index]
                                                        .status! -
                                                    3; */
                                          });
                                          log('currentStep:${MyOrderBloc.instance.currentStep}');
                                          AppRoutes.pushNamedNavigator(
                                              routeName:
                                                  Routes.driverOrderStatus,
                                              arguments: MyOrderBloc.instance
                                                  .allOrdersModel[index]);
                                          /* MyOrderBloc.instance.getOrderDetails(
                                                orderId: MyOrderBloc.instance
                                                    .orderStatusModel[index].id!); */
                                          /* MyOrderBloc.instance
                                                .add(OrderStatusClick()); */
                                        } else {
                                          /*  MyOrderBloc.instance.orderId = MyOrderBloc.instance
                                                    .orderStatusModel[index].id!; */
                                          AppRoutes.pushNamedNavigator(
                                              routeName: Routes.orderDetails,
                                              arguments: MyOrderBloc.instance
                                                  .allOrdersModel[index].id!);
                                        }
                                      },
                                      child: OrderStatusCard(
                                        date: MyOrderBloc.instance
                                            .allOrdersModel[index].date!,
                                        sendLocation: MyOrderBloc
                                            .instance
                                            .allOrdersModel[index]
                                            .deleviryLocation!,
                                        receiveLocation: MyOrderBloc
                                            .instance
                                            .allOrdersModel[index]
                                            .pickupLocation!,
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: Text('لا يوجد طلبات',
                                      style: TextStyleHelper.subtitle17),
                                ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
