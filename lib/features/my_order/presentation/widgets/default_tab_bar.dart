import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/my_order/data/view_model/bloc/my_order_bloc.dart';
import 'package:pick_up/features/my_order/presentation/widgets/custom_indicator.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DefaultTabBar extends StatefulWidget {
  final List content;
  final TabController tabController;
  const DefaultTabBar({
    super.key,
    required this.content,
    required this.tabController,
  });

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //   padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0.r)),
      ), // Background color of the tab bar
      height: MediaQueryHelper.height * .07, // Adjust the height of the tab bar
      child: TabBar(
        padding: EdgeInsets.zero,
        labelPadding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        controller: widget.tabController,
        tabs: List.generate(
          widget.content.length,
          (index) => Tab(
            height: MediaQueryHelper.height * .04,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.content[index],
                    textAlign: TextAlign.center,
                    style: TextStyleHelper.body15.copyWith(
                        fontWeight: FontWeight.normal,
                        color: MyOrderBloc.instance.tabBarCurrentIndex == index
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
          //indicatorWidth: 20,
          indicatorHeight: 5.0,
          indicatorColor: Theme.of(context).colorScheme.primary,
          tabBarIndicatorSize: 2.0.r,
          tabBarIndicatorRadius: 10.0.r,
        ),
      ),
    );
  }
}
