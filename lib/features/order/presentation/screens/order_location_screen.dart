import 'dart:async';

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
