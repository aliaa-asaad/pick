import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/order/presentation/widgets/car_card.dart';
import 'package:pick_up/features/order/presentation/widgets/order_data_type_card.dart';
import 'package:pick_up/features/order/presentation/widgets/order_type.dart';
import 'package:pick_up/features/order/presentation/widgets/title_text.dart';
import 'package:pick_up/utilities/media_quary.dart';

class OrderDataScreen extends StatefulWidget {
  const OrderDataScreen({
    super.key,
  });

  @override
  State<OrderDataScreen> createState() => _OrderDataScreenState();
}

class _OrderDataScreenState extends State<OrderDataScreen> with Validations {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Form(
          key: OrderBloc.instance.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(24.0.r, 24.0.r, 24.0.r, 0),
                child: const TitleText(title: "حدد نوع الشاحنة"),
              ),
              const CarCard(),
              Padding(
                padding: EdgeInsets.fromLTRB(24.0.r,0, 24.0.r,  24.0.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(title: "حدد نوع الشحنة"),
                    const OrderType(),
                    const TitleText(title: "مواصفات شحنتك"),
                    CustomFormField(
                        validator: isValidContent,
                        isAuth: false,
                        hintText: 'وصف لشحنتك. مثال عدد 4 كراسى او جهاز تليفزيون',
                        keyboardType: TextInputType.text,
                        controller:
                            OrderBloc.instance.orderDescriptionController),
                    const TitleText(title: 'خدمات التحميل والتنزيل'),
                    OrderDetailsTypeCard(
                      orderDetailsTypeData:
                          OrderBloc.instance.orderDetailsTypeData,
                      type: 'خدمات التحميل والتنزيل',
                    ),
                    const TitleText(title: 'حدد طابق الاستلام والتسليم'),
                    SizedBox(
                      height: MediaQueryHelper.height * .01,
                    ),
                    CustomFormField(
                        validator: isValidContent,
                        isAuth: false,
                        hintText: 'حدد طابق الاستلام',
                        keyboardType: TextInputType.number,
                        controller:
                            OrderBloc.instance.orderRecieveFloorController),
                    SizedBox(
                      height: MediaQueryHelper.height * .01,
                    ),
                    CustomFormField(
                        validator: isValidContent,
                        isAuth: false,
                        hintText: 'حدد طابق التسليم',
                        keyboardType: TextInputType.number,
                        controller: OrderBloc.instance.orderSendFloorController),
                    /* const Floor(), */
                    const TitleText(title: "المصعد الكهربائي"),
                    OrderDetailsTypeCard(
                      orderDetailsTypeData: OrderBloc.instance.additionalService,
                      type: "المصعد الكهربائي",
                    ),
                    const TitleText(title: "عامل إضافي"),
                    OrderDetailsTypeCard(
                        orderDetailsTypeData:
                            OrderBloc.instance.additionalService,
                        type: "عامل إضافي"),
                    CustomButton(
                      onPressed: () {
                        if (OrderBloc.instance.formKey.currentState!.validate()) {
                          if (OrderBloc.instance.isValidData()) {
                            log('valid');
                            OrderBloc.instance.viewCounter(back: false);
              
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
                      text: 'التالي',
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
