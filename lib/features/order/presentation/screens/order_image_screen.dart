import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/handlers/image_picker_handler.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderImageScreen extends StatefulWidget {
  const OrderImageScreen({
    super.key,
  });

  @override
  State<OrderImageScreen> createState() => _OrderImageScreenState();
}

class _OrderImageScreenState extends State<OrderImageScreen> {
  // File? picker;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.0.r),
      physics: const BouncingScrollPhysics(),
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
              InkWell(
                onTap: OrderBloc.instance.imagesList.length > 9
                    ? null
                    : () async {
                        List<File> image =
                            await ImagePickerHandler().getImage();
                        setState(() {
                          for (var i in image) {
                            OrderBloc.instance.imagesList.add(i);
                          }
                        });
                      },
                child: DottedBorder(
                  color: Theme.of(context).colorScheme.primary,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(16.r),
                  dashPattern: const [8, 4],
                  strokeWidth: 1,
                  child: Container(
                    //alignment: Alignment.center,
                    height: MediaQueryHelper.height * 0.23,
                    padding: EdgeInsets.all(8.r),
                    width: MediaQueryHelper.width,
                    decoration: BoxDecoration(
                      /* color: Color(0xff).withOpacity(.5), */
                      color: const Color(0xffF3C95B73).withOpacity(.5),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.uploadIcon,
                          height: MediaQueryHelper.height * .08,
                        ),
                        TextButton(
                          onPressed: OrderBloc.instance.imagesList.length > 9
                              ? null
                              : () async {
                                  var image =
                                      await ImagePickerHandler().getCameraImage();
                                  setState(() {
                                    OrderBloc.instance.imagesList.add(image);
                                  });
                                },
                          child: Text(
                            'صور شحنتك',
                            style: TextStyleHelper.subtitle20
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: OrderBloc.instance.imagesList.length > 9
                              ? null
                              : () async {
                                  List<File> image = await ImagePickerHandler()
                                      .getImage();
                                  setState(() {
                                    for (var i in image) {
                                      OrderBloc.instance.imagesList.add(i);
                                    }
                                  });
                                },
                          child: Text(
                            'تصفح المعرض',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQueryHelper.height * .02,
              ),
              Text(
                'الصور',
                style: TextStyleHelper.subtitle20,
              ),
              Column(
                children: List.generate(
                  OrderBloc.instance.imagesList.length,
                  (index) => Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.r),
                        height: MediaQueryHelper.height * 0.1,
                        width: MediaQueryHelper.width * .2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            image: DecorationImage(
                                image: FileImage(
                                    OrderBloc.instance.imagesList[index]),
                                fit: BoxFit.cover)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            OrderBloc.instance.imagesList[index].parent
                                .toString()
                                .split('/')
                                .last
                                .characters
                                .take(10)
                                .toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(),
                          ),
                          Text(
                              '${OrderBloc.instance.imagesList[index].readAsBytesSync().lengthInBytes.toInt() ~/ 1000} kb '),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              OrderBloc.instance.imagesList.removeAt(index);
                            });
                          },
                          icon: SvgPicture.asset(AppImages.deleteIcon))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQueryHelper.height * .04,
              ),
              CustomButton(
                onPressed: () {
                  if (OrderBloc.instance.formKey.currentState!.validate()) {
                    if (OrderBloc.instance.isValidImages()) {
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
                          content: Text('الرجاء ادخال كل البيانات المطلوبة ')),
                    );
                  }
                },
                text: 'التالي',
                background: Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
