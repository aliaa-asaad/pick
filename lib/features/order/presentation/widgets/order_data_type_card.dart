import 'package:flutter/material.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderDetailsTypeCard extends StatefulWidget {
  final String type;
  final List<String> orderDetailsTypeData;

  OrderDetailsTypeCard({
    super.key,
    /*  required this.orderDetailsTypeIndex, */
    required this.orderDetailsTypeData,
    required this.type,
  });

  @override
  State<OrderDetailsTypeCard> createState() => _OrderDetailsTypeCardState();
}

class _OrderDetailsTypeCardState extends State<OrderDetailsTypeCard> {
  int orderDetailsTypeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQueryHelper.height * .1,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: MediaQueryHelper.width * .05,
          mainAxisSpacing:
              MediaQueryHelper.height * .01, /*  mainAxisExtent: 500 */
        ),
        itemCount: widget.orderDetailsTypeData.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              if (widget.type == 'خدمات التحميل والتنزيل') {
                orderDetailsTypeIndex = index;
                OrderBloc.instance.orderDetailsTypeIndex =
                    orderDetailsTypeIndex;
              } else if (widget.type == 'المصعد الكهربائي') {
                orderDetailsTypeIndex = index;
                OrderBloc.instance.additionalServiceIndex1 =
                    orderDetailsTypeIndex;
              } else if (widget.type == 'عامل إضافي') {
                orderDetailsTypeIndex = index;
                OrderBloc.instance.additionalServiceIndex2 = 0;
              }
              // abdalazemSaleh
              // abdalazem.saleh2@icloud.com
              /* else if (widget.type == 'المصعد الكهربائي')
              log('orderDetailsTypeIndex: ${widget.orderDetailsTypeIndex}'); */
            });
          },
          child: Container(
            height: MediaQueryHelper.height * .1,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: orderDetailsTypeIndex == index
                      ? Colors.green
                      : Colors.grey.shade200,
                  width: 1.5),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Text(widget.orderDetailsTypeData[index]),
                const Spacer(),
                Icon(
                  Icons.check_circle,
                  color: orderDetailsTypeIndex == index
                      ? Colors.green
                      : Colors.grey,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
