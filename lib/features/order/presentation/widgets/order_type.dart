import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderType extends StatefulWidget {
  const OrderType({super.key});

  @override
  State<OrderType> createState() => _OrderTypeState();
}

class _OrderTypeState extends State<OrderType> {
  @override
  Widget build(BuildContext context) {
    var bloc = BlocProvider.of<OrderBloc>(context);
    return SizedBox(
      height: 150,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: 8.r,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: MediaQueryHelper.width * .05,
          mainAxisSpacing:
              MediaQueryHelper.height * .01, /*  mainAxisExtent: 500 */
        ),
        itemCount: bloc.orderTypeData.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              bloc.orderTypeIndex = index;
            });
          },
          child: Container(
            height: MediaQueryHelper.height * .1,
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: bloc.orderTypeIndex == index
                      ? Colors.green
                      : Colors.grey.shade200,
                  width: 1.5),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(
                  bloc.orderTypeData[index],
                  style: TextStyleHelper.button13
                      .copyWith(fontWeight: FontWeight.normal),
                ),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color:
                      bloc.orderTypeIndex == index ? Colors.green : Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
