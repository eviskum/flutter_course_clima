import 'package:flutter/material.dart';
import 'package:flutter_course_clima/services/location.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Location? _location;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  void getLocation() {
    _location = Location()..getCurrentLocation();
  }

  void getData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            // getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
