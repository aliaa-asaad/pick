import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/handlers/shared_handler.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderStatusCard extends StatefulWidget {
  final String sendLocation;
  final String receiveLocation;
  final String date;
  const OrderStatusCard(
      {super.key,
      required this.sendLocation,
      required this.receiveLocation,
      required this.date});

  @override
  State<OrderStatusCard> createState() => _OrderStatusCardState();
}

class _OrderStatusCardState extends State<OrderStatusCard> {
  @override
  Widget build(BuildContext context) {
    int type = SharedHandler.instance!
        .getData(key: SharedKeys().userType, valueType: ValueType.int);
    return Padding(
      padding: EdgeInsets.only(bottom: 24.0.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'توصيل اغراضك',
                          style: TextStyleHelper.subtitle17.copyWith(
                              fontWeight: FontWeight.bold,
                              color: type == 0
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQueryHelper.height * .005,
                            ),
                            CircleAvatar(
                              radius: 6.r,
                              backgroundColor: type == 0
                                  ? const Color(0xff1C74F2).withOpacity(.1)
                                  : Theme.of(context).colorScheme.primary,
                              child: CircleAvatar(
                                radius: 4.r,
                                backgroundColor: type == 0
                                    ? const Color(0xff001833)
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            SizedBox(
                              height: MediaQueryHelper.height * .005,
                            ),
                            CircleAvatar(
                              radius: 1.r,
                              backgroundColor:
                                  const Color(0xff1C74F2).withOpacity(.5),
                            ),
                            SizedBox(
                              height: MediaQueryHelper.height * .005,
                            ),
                            CircleAvatar(
                              radius: 1.r,
                              backgroundColor:
                                  const Color(0xff1C74F2).withOpacity(.5),
                            ),
                            SizedBox(
                              height: MediaQueryHelper.height * .005,
                            ),
                            CircleAvatar(
                              radius: 6.r,
                              backgroundColor:
                                  const Color(0xff4F5E7B).withOpacity(.1),
                              child: CircleAvatar(
                                radius: 4.r,
                                backgroundColor: const Color(0xffDEDEDE),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQueryHelper.width * .01,
                        ),
                        Column(
                          children: [
                            Text(
                              widget.sendLocation,
                              style: TextStyleHelper.body15.copyWith(
                                color: const Color(0xff4F5E7B),
                              ),
                            ),
                            Text(
                              widget.receiveLocation,
                              style: TextStyleHelper.body15
                                  .copyWith(color: const Color(0xff4F5E7B)),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
               /*  type == 1
                    ? const SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          type == 0
                              ? Text(
                                  widget.date,
                                  style: const TextStyle(color: Colors.grey),
                                )
                              : Text.rich(
                                  TextSpan(
                                    text: '200',
                                    style: TextStyleHelper.subtitle17.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    children: [
                                      TextSpan(
                                        text: ' ريال',
                                        style: TextStyleHelper.button13
                                            .copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary),
                                      ),
                                    ],
                                  ),
                                ),
                          type == 0
                              ? const SizedBox()
                              : Text.rich(
                                  TextSpan(
                                    text: '5',
                                    style: TextStyleHelper.subtitle17.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff4F5E7B)),
                                    children: [
                                      TextSpan(
                                        text: '   ك.م',
                                        style: TextStyleHelper.button13
                                            .copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: const Color(0xff4F5E7B)),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      )
           */    ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .07,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16.r),
              ),
            ),
            child: Text(
              'التفاصيل',
              style: TextStyleHelper.body15.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
