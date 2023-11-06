import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/my_order/data/view_model/cubit/my_order_cubit.dart';
import 'package:pick_up/features/my_order/presentation/widgets/default_tab_bar.dart';
import 'package:pick_up/features/my_order/presentation/widgets/order_status_card.dart';
import 'package:pick_up/routing/navigator.dart';
import 'package:pick_up/routing/routes.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class ClientOrderScreen extends StatefulWidget {
  const ClientOrderScreen({super.key});

  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyOrderCubit.instance.getOrderStatus();
  }

  @override
  Widget build(BuildContext context) {
    List<String> content = [
      'طلبات حالية',
      'طلبات منتهية',
    ];
    return BlocBuilder<MyOrderCubit, MyOrderState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text('طلباتي'),
          titleTextStyle: TextStyleHelper.subtitle20.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontFamily:
                  Theme.of(context).appBarTheme.titleTextStyle!.fontFamily),
        ),
        body: SafeArea(
          child: Column(
            children: [
              DefaultTabBar(content: content,),
              Expanded(
                child: state is MyOrderLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : state is MyOrderError
                        ? const Center(child: Text('Error'))
                        : MyOrderCubit.instance.orderStatusModel.isNotEmpty
                            ? ListView.builder(
                                padding: EdgeInsets.all(24.r),
                                itemCount: MyOrderCubit
                                    .instance.orderStatusModel.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      AppRoutes.pushNamedNavigator(
                                          routeName: Routes.orderDetails,
                                          arguments: MyOrderCubit.instance
                                              .orderStatusModel[index].id);
                                    },
                                    child: OrderStatusCard(
                                      date: MyOrderCubit.instance
                                          .orderStatusModel[index].date!,
                                      sendLocation: MyOrderCubit
                                          .instance
                                          .orderStatusModel[index]
                                          .deleviryLocation!,
                                      receiveLocation: MyOrderCubit
                                          .instance
                                          .orderStatusModel[index]
                                          .pickupLocation!,
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text('لا يوجد طلبات',
                                    style: TextStyleHelper.subtitle18),
                              ),
              )
            ],
          ),
        ),
      );
    });
  }
}
