import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/my_order/data/view_model/cubit/my_order_cubit.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class DefaultTabBar extends StatefulWidget {
  final List content;

  const DefaultTabBar({
    super.key,
    required this.content,
  });

  @override
  State<DefaultTabBar> createState() => _DefaultTabBarState();
}

class _DefaultTabBarState extends State<DefaultTabBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryHelper.width,
      height: MediaQueryHelper.height * .07,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.content.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  MyOrderCubit.instance.tabBarCurrentIndex = index;
                  MyOrderCubit.instance.getOrderStatus();
                });
              },
              child: Column(
                crossAxisAlignment: index == 1
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: MediaQueryHelper.width * .45,
                    child: Text(
                      widget.content[index],
                      textAlign: TextAlign.center,
                      style: TextStyleHelper.subtitle18.copyWith(
                          color:
                              MyOrderCubit.instance.tabBarCurrentIndex == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey),
                    ),
                  ),
                  AnimatedContainer(
                    curve: Curves.linear,
                    duration: const Duration(milliseconds: 100),
                    width: MyOrderCubit.instance.tabBarCurrentIndex == index
                        ? MediaQueryHelper.width * .45
                        : 0,
                    height: MediaQueryHelper.height * .007,
                    decoration: BoxDecoration(
                      color: /*  currentIndex == index
                                  ? */
                          Theme.of(context)
                              .colorScheme
                              .primary /* : Colors.transparent */,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
