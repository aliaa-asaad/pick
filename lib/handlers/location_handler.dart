import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationHandler {
  //goelocator package
  static Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isServiceEnabled == false || permission == LocationPermission.denied) {
      //await Geolocator.openLocationSettings();
      await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  //geocoding package
  static Future<List<double>> getLocationFromAddress({required String location}) async {
    try {
      List<Location> locations = await locationFromAddress(location);

      double? latitude = locations[0].latitude;
      double? longitude = locations[0].longitude;
return [latitude,longitude];
    } catch (e) {
      log('getLocationFromAddress error: $e');
      return [];
    }
  }
}
