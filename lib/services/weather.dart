import 'dart:convert';

import 'package:flutter_course_clima/models/weather_data.dart';
import 'package:flutter_course_clima/services/location.dart';
import 'package:flutter_course_clima/utilities/api_keys.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherModel {
  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }

  static Future<WeatherData?> getWeatherData({String? cityName = null}) async {
    try {
      Uri owUri;
      if (cityName == null) {
        Position _position = await Location.determinePosition();
        owUri = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
          'lat': _position.latitude.toString(),
          'lon': _position.longitude.toString(),
          'units': 'metric',
          'appid': kWhetherApiKey,
        });
      } else {
        owUri = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
          'q': cityName,
          'units': 'metric',
          'appid': kWhetherApiKey,
        });
      }
      print(owUri.toString());
      http.Response response = await http.get(owUri);
      if (response.statusCode == 200) {
        return WeatherData.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Weather web service call failed');
      }
    } catch (e) {
      print('Unable to get weather date:');
      print(e);
      return null;
    }
    // if (_weatherData != null) Navigator.of(context).pushNamed(LocationScreen.routeName, arguments: _weatherData);
  }
}
