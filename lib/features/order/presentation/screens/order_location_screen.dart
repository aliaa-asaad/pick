/* import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/features/order/presentation/widgets/google_map.dart';
import 'package:pick_up/handlers/location_handler.dart';

class OrderLocationScreen extends StatefulWidget {
  final Function() onPressed;
  const OrderLocationScreen({super.key, required this.onPressed});

  @override
  State<OrderLocationScreen> createState() => _OrderLocationScreenState();
}

class _OrderLocationScreenState extends State<OrderLocationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  static Position? position;
  final Completer<GoogleMapController> _controller = Completer();
  //هيجيب اللوكيشن بتاعي الحالي ويديه للجوجل ماب بعدين
  static final CameraPosition myCurrentLocationCameraPosition = CameraPosition(
    target: LatLng(position!.latitude, position!.longitude),
    //اما الماب بتحمل هو بيوريني اللوكيشن بتاعي الحالي بس
    //من ناحية الزوم فكل ما اكبر الرقم هيظهر اللويشن بشكل اكبر عالماب
    zoom: 17.4746,
    //بيتحكم في ابعاد الكاميرا
    bearing: 0,
    //بتتحكم فالكاميرا والزوايا وكدا
    tilt: 5,
  );
  Future<void> getCurrentLocation() async {
    await LocationHandler.getCurrentLocation();
    position = (await Geolocator.getCurrentPosition()
        .whenComplete(() => setState(() {})));
  }

  /*  Widget buildMap() {
    return GoogleMap(
      initialCameraPosition: myCurrentLocation,
      //شكل الماب هيقبي عامل ازاي يعي هتبقي ماب عادية زي
      // الللي عارفينها ولا ماب زي بتاعة الستالايت ولا ايه
      mapType: MapType.normal,
      // بيعمل نقطة زرقة عاللوكيشن اللي انا فيه
      myLocationButtonEnabled: true,
      //بيظهر تحت زرارين للتكبير والتصغير فهو هيلغيهم لان انا كدا كدا بقدر اكبر واصغر بنفسي عادي
      zoomControlsEnabled: false,
      // بيظهرلي بوتون بيجيبلي اللوكيشن الحالي بتاعي
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) =>
          _controller.complete(controller),
    );
  } */

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return position == null
        ? const Center(child: CircularProgressIndicator())
        : CustomScrollView(
            slivers: [
              GoogleMapWidget(
                  location: myCurrentLocationCameraPosition,
                  mapController: _controller),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24.0.r),
                  child: Column(
                    children: [
                      CustomFormField(isSearch: true,
                          hintText: 'ابحث عن عنوان الاستلام',
                          keyboardType: TextInputType.name,
                          controller: controller),
                      Text(controller.text),
                          CustomFormField(isSearch: true,
                          hintText: 'ابحث عن عنوان التوصيل',
                          keyboardType: TextInputType.name,
                          controller: controller),
                      Text(controller.text),
                      CustomButton(
                          onPressed: widget.onPressed,
                          text: 'التالي',
                          background: Theme.of(context).colorScheme.primary)
                      //Spacer()
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
 */
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pick_up/app_widgets/custom_button.dart';
import 'package:pick_up/app_widgets/custom_form_field.dart';
import 'package:pick_up/core/validator.dart';
import 'package:pick_up/features/order/data/view_model/bloc/order_bloc.dart';
import 'package:pick_up/utilities/images.dart';
import 'package:pick_up/utilities/media_quary.dart';
import 'package:pick_up/utilities/text_style.dart';

class OrderLocationScreen extends StatefulWidget {
  const OrderLocationScreen({
    super.key,
  });

  @override
  State<OrderLocationScreen> createState() => _OrderLocationScreenState();
}

class _OrderLocationScreenState extends State<OrderLocationScreen>
    with Validations {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                children: [
                  Image.asset(
                    AppImages.orderLocationPNG,
                    height: MediaQueryHelper.height * .35,
                  ),
                  Container(
                    width: MediaQueryHelper.width,
                    height: MediaQueryHelper.height * 0.52,
                    padding: EdgeInsets.all(24.0.r),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 0.5,
                          blurRadius: 7,
                          offset: const Offset(0, -3), // changes position of shadow
                        ),
                      ],
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('موقع الاستلام'),
                        SizedBox(
                          height: MediaQueryHelper.height * .01,
                        ),
                        CustomFormField(
                            validator: isValidContent,
                            isAuth: false,
                            hintText: 'ابحث عن عنوان الاستلام',
                            keyboardType: TextInputType.name,
                            controller:
                                OrderBloc.instance.orderRecieveLocationController),
                        SizedBox(
                          height: MediaQueryHelper.height * .01,
                        ),
                        const Text('موقع التسليم'),
                        SizedBox(
                          height: MediaQueryHelper.height * .01,
                        ),
                        CustomFormField(
                            validator: isValidContent,
                            isAuth: false,
                            hintText: 'ابحث عن عنوان التسليم',
                            keyboardType: TextInputType.name,
                            controller:
                                OrderBloc.instance.orderSendLocationController),
    SizedBox(
                      height: MediaQueryHelper.height * .02,
                    ),
                    state is OrderError
                        ? Text(
                            'هناك خطا في ارسال البيانات',
                            style: TextStyleHelper.subtitle20,
                          )
                        : const SizedBox(),
                        Center(
                          child: CustomButton(
                            onPressed: () {
                              if (OrderBloc.instance.formKey.currentState!
                                  .validate()) {
                                if (OrderBloc.instance.isValidLocation()) {
                                  log('valid');
                                 /*  OrderBloc.instance.viewCounter(back: false); */
                                  OrderBloc.instance.add(OrderDataClick());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('حفظ البيانات')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'الرجاء ادخال كل البيانات المطلوبة ')),
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
                            
                          ),
                        )
                        //Spacer()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
