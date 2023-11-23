import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/my_order/presentation/widgets/default_tab_bar.dart';
import 'package:pick_up/features/my_order/presentation/widgets/order_status_card.dart';
import 'package:pick_up/features/payment/data/view_model/bloc/payment_bloc.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/text_style.dart';

class ClientOrderScreen extends StatefulWidget {
  const ClientOrderScreen({super.key});

  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    MyOrderBloc.instance.getAllOrders();
    log('test ');
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> content = [
      'طلبات حالية',
      'قيدالانتظار',
      'طلبات منتهية',
    ];
    return BlocBuilder<MyOrderBloc, MyOrderState>(builder: (context, state) {
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
                        ? const Center(child: Text('Error'))
                        : MyOrderBloc.instance.allOrdersModel.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.all(24.r),
                                itemCount:
                                    MyOrderBloc.instance.allOrdersModel.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      log('tabController.index:${_tabController.index}');
                                      if (_tabController.index == 1) {
                                        log('1111111111111111111111111111111111111111');
                                        MyOrderBloc.instance.getOrderDetails(
                                            orderId: MyOrderBloc.instance
                                                .allOrdersModel[index].id!);
                                        SharedHandler.instance!.getData(
                                                    key: SharedKeys()
                                                        .countryType,
                                                    valueType: ValueType.int) ==
                                                0
                                            ? PaymentBloc.instance
                                                .add(KSAPaymentClick())
                                            : PaymentBloc.instance
                                                .add(GetEGPaymentClick());
                                      } else {
                                        log('222222222222222222222222222222222');
                                        AppRoutes.pushNamedNavigator(
                                            routeName: Routes.orderDetails,
                                            arguments: MyOrderBloc.instance
                                                .allOrdersModel[index].id);
                                      }
                                    },
                                    child: OrderStatusCard(
                                      date: MyOrderBloc
                                          .instance.allOrdersModel[index].date!,
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
    });
  }
}
