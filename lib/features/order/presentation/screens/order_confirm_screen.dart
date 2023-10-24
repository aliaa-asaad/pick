import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/order/presentation/widgets/confirm_content.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({
    super.key,
  });

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> content = [
      {
        'title': 'نوع الشاحنة',
        'content': 'OrderBloc.instance.carCardData[OrderBloc.instance.carIndex]'
      },
      {
        'title': 'نوع الشحنة',
        'content':
            OrderBloc.instance.orderTypeData[OrderBloc.instance.orderTypeIndex]
      },
      {
        'title': 'مواصفات شحنتك',
        'content': OrderBloc.instance.orderDescriptionController.text
      },
      {
        'title': 'خدمات التحميل والتنزيل',
        'content': OrderBloc.instance
            .orderDetailsTypeData[OrderBloc.instance.orderDetailsTypeIndex],
      },
      {
        'title': 'المصعد الكهربائي',
        'content': OrderBloc.instance
            .additionalService[OrderBloc.instance.elevatorAvilabelIndex]
      },
      {
        'title': 'عامل إضافي',
        'content': OrderBloc.instance
            .additionalService[OrderBloc.instance.extramanAvilabelIndex]
      },
    ];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(16.0.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: MediaQueryHelper.height * .78,
                width: MediaQueryHelper.width,
              ),
              Container(
                margin: EdgeInsets.only(
                    right: MediaQueryHelper.width * .015,
                    top: MediaQueryHelper.height * .02),
                height: MediaQueryHelper.height * .72,
                width: MediaQueryHelper.width * .003,
                //color: Colors.grey,
              ),
              Column(
                children: List.generate(
                  content.length,
                  (index) => ConfirmContent(
                      title: content[index]['title'],
                      content: content[index]['content'],
                      card: index == 0
                          ? Row(
                              children: [
                                Image.asset(
                                  OrderBloc.instance.carCardData[
                                      OrderBloc.instance.carIndex]['image'],
                                  height: MediaQueryHelper.height * .1,
                                  width: MediaQueryHelper.width * .3,
                                ),
                                SizedBox(
                                  width: MediaQueryHelper.width * .03,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(OrderBloc.instance.carCardData[
                                        OrderBloc.instance.carIndex]['title']),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.length),
                                        SizedBox(
                                          width: MediaQueryHelper.width * .01,
                                        ),
                                        Text(
                                          OrderBloc.instance.carCardData[
                                                  OrderBloc.instance.carIndex]
                                              ['length'],
                                          style: const TextStyle(),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppImages.weight),
                                        SizedBox(
                                          width: MediaQueryHelper.width * .01,
                                        ),
                                        Text(
                                          OrderBloc.instance.carCardData[
                                                  OrderBloc.instance.carIndex]
                                              ['weight'],
                                          style: const TextStyle(),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            )
                          : null),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQueryHelper.height * .02,
          ),
          const Divider(
            //thickness: 1.5,
            color: Colors.grey,
          ),
          Row(
            children: [
              const Text(
                'موقع استلام البضائع',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  OrderBloc.instance.viewCounter(back: true);
                },
                icon: SvgPicture.asset(AppImages.mapIcon),
                label: const Text(
                  'تعديل',
                  style: TextStyle(color: Color(0xff4F5E7B)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppImages.locationIcon),
              SizedBox(
                width: MediaQueryHelper.width * .02,
              ),
              Text(
                OrderBloc.instance.orderRecieveLocationController.text,
                style: const TextStyle(
                  color: Color(0xff4F5E7B),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'موقع توصيل البضائع',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {
                  OrderBloc.instance.viewCounter(back: true);
                },
                icon: SvgPicture.asset(AppImages.mapIcon),
                label: const Text(
                  'تعديل',
                  style: TextStyle(color: Color(0xff4F5E7B)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(AppImages.locationIcon),
              SizedBox(
                width: MediaQueryHelper.width * .02,
              ),
              Text(
                OrderBloc.instance.orderSendLocationController.text,
                style: const TextStyle(color: Color(0xff4F5E7B)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQueryHelper.height * .02,
          ),
          const Divider(
            //thickness: 1.5,
            color: Colors.grey,
          ),
          Text(
            'التكلفة التقريبية',
            style: TextStyleHelper.subtitle20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('رسوم التوصيل',
                  style: TextStyleHelper.subtitle18
                      .copyWith(color: const Color(0xff4F5E7B))),
              const Spacer(),
              Text('150 ريال',
                  style: TextStyleHelper.subtitle18
                      .copyWith(color: const Color(0xff4F5E7B))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('تكلفة العامل الاضافي',
                  style: TextStyleHelper.subtitle18
                      .copyWith(color: const Color(0xff4F5E7B))),
              const Spacer(),
              Text('150 ريال',
                  style: TextStyleHelper.subtitle18
                      .copyWith(color: const Color(0xff4F5E7B))),
            ],
          ),
          SizedBox(
            height: MediaQueryHelper.height * .02,
          ),
          const Divider(
            //thickness: 1.5,
            color: Colors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('الاجمالي',
                  style: TextStyleHelper.subtitle18
                      .copyWith(color: const Color(0xff4F5E7B))),
              const Spacer(),
              Text('300 ريال',
                  style: TextStyleHelper.subtitle18
                      .copyWith(color: const Color(0xff4F5E7B))),
            ],
          ),
          Text('شامل قيمة الضربية المضافة',
              style: TextStyleHelper.subtitle18.copyWith(color: Colors.grey)),
          CustomButton(
            onPressed: () {
              OrderBloc.instance.viewCounter(back: false);
            },
            text: 'التالي',
          )
        ],
      ),
    );
  }
}
