import 'package:flutter/material.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderDetailsTypeCard extends StatefulWidget {
  final String type;
  final List<String> orderDetailsTypeData;

  const OrderDetailsTypeCard({
    super.key,
    /*  required this.orderDetailsTypeIndex, */
    required this.orderDetailsTypeData,
    required this.type,
  });

  @override
  State<OrderDetailsTypeCard> createState() => _OrderDetailsTypeCardState();
}

class _OrderDetailsTypeCardState extends State<OrderDetailsTypeCard> {
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
        itemBuilder: (context, index) {
          if (widget.type == 'خدمات التحميل والتنزيل') {
            OrderBloc.instance.orderDetailsTypeIndex =
                OrderBloc.instance.orderDetailsTypeInitialIndex;
          } else if (widget.type == 'المصعد الكهربائي') {
            OrderBloc.instance.elevatorAvilabelIndex =
                OrderBloc.instance.orderDetailsTypeInitialIndex;
          } else if (widget.type == 'عامل إضافي') {
            OrderBloc.instance.extramanAvilabelIndex =
                OrderBloc.instance.orderDetailsTypeInitialIndex;
          }
          return InkWell(
            onTap: () {
              setState(() {
                OrderBloc.instance.orderDetailsTypeInitialIndex = index;

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
                    color:
                        OrderBloc.instance.orderDetailsTypeInitialIndex == index
                            ? Colors.green
                            : Colors.grey.shade200,
                    width: 1.5),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Text(widget.orderDetailsTypeData[index],style: TextStyleHelper.button13.copyWith(fontWeight: FontWeight.normal),),
                  const Spacer(),
                  Icon(
                    Icons.check_circle,
                    color:
                        OrderBloc.instance.orderDetailsTypeInitialIndex == index
                            ? Colors.green
                            : Colors.grey,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
