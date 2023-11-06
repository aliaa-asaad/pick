import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _location = 'القاهرة';
  double? _latitude;
  double? _longitude;

  @override
  void initState() {
    super.initState();
    getLocationFromAddress();
  }

  Future<void> getLocationFromAddress() async {
    try {
      List<Location> locations = await locationFromAddress(_location);
      setState(() {
        _latitude = locations[0].latitude;
        _longitude = locations[0].longitude;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geocoding Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Address: $_location'),
            SizedBox(height: 20),
            Text('Latitude: ${_latitude ?? 'Unknown'}'),
            SizedBox(height: 10),
            Text('Longitude: ${_longitude ?? 'Unknown'}'),
          ],
        ),
      ),
    );
  }
}
