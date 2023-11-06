import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/app_widgets/confirm_additional_services.dart';
import 'package:pick_up/features/order/presentation/widgets/confirm_car_card.dart';
import 'package:pick_up/app_widgets/confirm_content.dart';
import 'package:pick_up/features/order/presentation/widgets/order_location.dart';
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
    ];
    List<Map<String, dynamic>> additionalService = [
      {
        'title': 'خدمات التحميل والتنزيل',
        'type': OrderBloc.instance
            .additionalService[OrderBloc.instance.orderDetailsTypeIndex],
        'index': OrderBloc.instance.orderDetailsTypeIndex
      },
      {
        'title': 'المصعد الكهربائي',
        'type': OrderBloc.instance
            .additionalService[OrderBloc.instance.elevatorAvilabelIndex],
        'index': OrderBloc.instance.elevatorAvilabelIndex
      },
      {
        'title': 'عامل إضافي',
        'type': OrderBloc.instance
            .additionalService[OrderBloc.instance.extramanAvilabelIndex],
        'index': OrderBloc.instance.extramanAvilabelIndex
      },
    ];
    return BlocBuilder<OrderBloc, OrderState>(builder: (context, state) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.0.r),
        child: Form(
          key: OrderBloc.instance.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: InkWell(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: List.generate(
                    content.length,
                    (index) => ConfirmContent(
                        contentList: content,
                        title: content[index]['title'],
                        content: content[index]['content'],
                        card: index == 0
                            ? ConfirmCarCard(
                                image: OrderBloc.instance.carCardData[
                                    OrderBloc.instance.carIndex]['image'],
                                title: OrderBloc.instance.carCardData[
                                    OrderBloc.instance.carIndex]['title'],
                                length: OrderBloc.instance.carCardData[
                                    OrderBloc.instance.carIndex]['length'],
                                weight: OrderBloc.instance.carCardData[
                                    OrderBloc.instance.carIndex]['weight'],
                              )
                            : null),
                  ),
                ),
                Column(
                  children: List.generate(
                    additionalService.length,
                    (index) => ConfirmAdditionalServices(
                        isAvailable: additionalService[index]['index'],
                        title: additionalService[index]['title'],
                        type: additionalService[index]['type']),
                  ),
                ),
                SizedBox(
                  height: MediaQueryHelper.height * .02,
                ),
                const Divider(
                  //thickness: 1.5,
                  color: Colors.grey,
                ),
                OrderLocation(
                    title: 'موقع استلام البضائع',
                    location:
                        OrderBloc.instance.orderRecieveLocationController.text),
                OrderLocation(
                    title: 'موقع توصيل البضائع',
                    location:
                        OrderBloc.instance.orderSendLocationController.text),
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
                    style: TextStyleHelper.subtitle18
                        .copyWith(color: Colors.grey)),
                CustomButton(
                  onPressed: () {
                    if (OrderBloc.instance.formKey.currentState!.validate()) {
                      if (OrderBloc.instance.isValidLocation()) {
                        log('valid');
                        /*  OrderBloc.instance.viewCounter(back: false); */
                        OrderBloc.instance.add(OrderSubmitClick());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('حفظ البيانات')),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('الرجاء ادخال كل البيانات المطلوبة ')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('الرجاء ادخال كل البيانات المطلوبة ')),
                      );
                    }
                  },
                  width: state is OrderLoading
                      ? MediaQueryHelper.width * .13
                      : MediaQueryHelper.width,
                  child: state is OrderLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'متابعة',
                          style: TextStyleHelper.subtitle20.copyWith(
                            color: Colors.white,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
