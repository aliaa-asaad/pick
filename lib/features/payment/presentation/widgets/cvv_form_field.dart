import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/features/profile/data/view_model/bloc/profile_bloc.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class CvvFormField extends StatelessWidget with Validations{
  const CvvFormField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQueryHelper.width * .42,
      height: MediaQueryHelper.height * .06,
      child: TextFormField(
        
        controller:
            OrderBloc.instance.cardCvvController,
        validator: isValidCVV,
        enabled: true,
        style: TextStyleHelper.button13.copyWith(
            height: 1.1.h, fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16.0.r),
            ),
          ),
          border: OutlineInputBorder(
            /* borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.green,
          ), */
          
            borderRadius: BorderRadius.all(
              Radius.circular(16.0.r),
            ),
          ),
          hintStyle: TextStyleHelper.button13.copyWith(
              color: Colors.grey, fontWeight: FontWeight.normal),
          errorStyle: TextStyleHelper.caption11,
          fillColor: Colors.white,
          filled: true,
          hintText: 'CVV',
          prefixIcon: Padding(padding: EdgeInsets.all(12.0.r),),
          /*  hintStyle: TextStyleHelper.subtitle19
                .copyWith(color: Colors.grey), */
        ),
      ),
    );
  }
}
