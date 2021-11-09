import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_course_clima/models/weather_data.dart';
import 'package:flutter_course_clima/screens/location_screen.dart';
import 'package:flutter_course_clima/services/location.dart';
import 'package:flutter_course_clima/services/weather.dart';
import 'package:flutter_course_clima/utilities/api_keys.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  // Location? _location;
  // Position? _position;
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    // getLocation();
    getWeatherData();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('deactivate called');
  }

  void getWeatherData() async {
    // try {
    //   _position = await Location.determinePosition();
    //   Uri owUri = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
    //     'lat': _position!.latitude.toString(),
    //     'lon': _position!.longitude.toString(),
    //     'units': 'metric',
    //     'appid': kWhetherApiKey,
    //   });
    //   http.Response response = await http.get(owUri);
    //   if (response.statusCode == 200) {
    //     _weatherData = WeatherData.fromJson(jsonDecode(response.body));
    //   } else {
    //     throw Exception('Weather web service call failed');
    //   }
    // } catch (e) {
    //   print('Unable to get weather date:');
    //   print(e);
    // }
    _weatherData = await WeatherModel.getWeatherData();
    if (_weatherData != null) Navigator.of(context).pushNamed(LocationScreen.routeName, arguments: _weatherData);
  }

  // void getLocation() {
  //   _location = Location()..getCurrentLocation();
  // }

  // void getData() async {
  //   if (_location != null && _location!.latitude != null && _location!.longitude != null) {
  //     Uri owUri = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
  //       'lat': _location!.latitude!.toString(),
  //       'lon': _location!.longitude!.toString(),
  //       'appid': kWhetherApiKey,
  //     });
  //     http.Response response = await http.get(owUri);
  //     if (response.statusCode == 200) {
  //       _weatherData = WeatherData.fromJson(jsonDecode(response.body));
  //       if (_weatherData == null)
  //         print('No weather data');
  //       else
  //         print(_weatherData!.weather[0].description);
  //     }

  //     print(response.body);
  //   } else {
  //     print('We dont have a location');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.white, size: 100),
      ),
    );
  }
}
