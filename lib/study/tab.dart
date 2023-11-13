import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/my_order/presentation/widgets/custom_indicator.dart';
import 'package:pick_up/features/my_order/presentation/widgets/order_status_card.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class MyTabBarTest extends StatefulWidget {
  @override
  _MyTabBarTestState createState() => _MyTabBarTestState();
}

class _MyTabBarTestState extends State<MyTabBarTest>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
                Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(16.0.r)),
                  ), // Background color of the tab bar
                  height: MediaQueryHelper.height *
                      .075, // Adjust the height of the tab bar
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    controller: _tabController,
                    tabs: List.generate(
                      content.length,
                      (index) => Tab(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(content[index],
                                textAlign: TextAlign.center,
                                style: TextStyleHelper.body15.copyWith(
                                    fontWeight: FontWeight.normal,
                                    color: MyOrderBloc
                                                .instance.tabBarCurrentIndex ==
                                            index
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                    onTap: (index) {
                      setState(() {
                        MyOrderBloc.instance.tabBarCurrentIndex = index;
                        MyOrderBloc.instance.getAllOrders();
                      });
                    },
                    indicator: CustomTabIndicator(
                      indicatorHeight: 5.0.r,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      tabBarIndicatorSize: 2.0.r,
                      tabBarIndicatorRadius: 10.0.r,
                    ),
                  ),
                ),
                Expanded(
                  child: state is MyOrderLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : state is MyOrderError
                          ? const Center(child: Text('Error'))
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
                                            MyOrderBloc.instance.currentStep =
                                                MyOrderBloc
                                                        .instance
                                                        .allOrdersModel[index]
                                                        .status! -
                                                    3;
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
                /*  Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildTabContent(0),
                      _buildTabContent(1),
                      _buildTabContent(2),
                      //  _buildTabContent(3),
                      // Add more pages as needed
                    ],
                  ),
                ), */
              ],
            ),
          ),
        );
      },
    );
  }
}
