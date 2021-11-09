import 'dart:convert';

import 'package:flutter_course_clima/models/weather_data.dart';
import 'package:flutter_course_clima/services/location.dart';
import 'package:flutter_course_clima/utilities/api_keys.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class WeatherModel {
  static String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  static String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  static Future<WeatherData?> getWeatherData() async {
    try {
      Position _position = await Location.determinePosition();
      Uri owUri = Uri.https('api.openweathermap.org', 'data/2.5/weather', {
        'lat': _position.latitude.toString(),
        'lon': _position.longitude.toString(),
        'units': 'metric',
        'appid': kWhetherApiKey,
      });
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
