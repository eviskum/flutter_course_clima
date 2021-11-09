import 'package:flutter/material.dart';
import 'package:flutter_course_clima/models/weather_data.dart';
import 'package:flutter_course_clima/services/weather.dart';
import 'package:flutter_course_clima/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  static String routeName = '/location';

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherData? args;

  @override
  void initState() {
    super.initState();

    // temp = args.main.temp
    // condition = args.weather[0].id
    // cityName = args.name
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as WeatherData;
  }

  void updateWeather() async {
    print('We are updating the location and weather');
    WeatherData? updatedWeather = await WeatherModel.getWeatherData();
    if (updatedWeather != null) {
      setState(() {
        args = updatedWeather;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      updateWeather();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${args!.main.temp.toStringAsFixed(0)}°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      // '☀️',
                      WeatherModel.getWeatherIcon(args!.weather[0].id),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  WeatherModel.getMessage(args!.main.temp.toInt()) + ' in ' + args!.name,
                  // "It's 🍦 time in San Francisco!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
