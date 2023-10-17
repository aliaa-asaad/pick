import 'package:geolocator/geolocator.dart';

class LocationHandler {
  static Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isServiceEnabled==false||permission == LocationPermission.denied) {
      //await Geolocator.openLocationSettings();
      await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location Not Available');
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,);
  }
}
