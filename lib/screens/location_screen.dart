import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String weatherIcon;
  String cityName;
  String countryName;
  String weatherMessage;
  var condition;
  String imageURL = 'images/ink-wash.png';

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
    updateScreenImage();
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to fetch the weather data';
        cityName = '';
        countryName = '';
        return;
      }
      double temp = weatherData['main']['temp'].toDouble();
      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      countryName = weatherData['sys']['country'];

      print('Temperature: $temperature');
      print('Condition ID: $condition');
      print('City: $cityName');
      print('Country: $countryName');
    });
  }

  void updateScreenImage() {
    if (condition == null) {
      return;
    }
    // thunder, rain, or drizzle - change the image
    if (condition < 600) {
      print('less then 600');
      imageURL = 'images/rain-julie-karlsson.jpg';
    } else if (600 < condition && condition < 700) {
      print('between 601 and 699');
      imageURL = 'images/lake.png';
    } else if (750 < condition && condition < 805) {
      print('between 751 and 805');
      imageURL = 'images/mountain.png';
    } else {
      imageURL = 'images/ink-wash.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            // image: AssetImage('images/ink-wash.png'),
            image: AssetImage('$imageURL'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                      updateScreenImage();
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 25.0,
                      color: Colors.black,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                        updateScreenImage();
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  cityName,
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.0),
                child: Text(
                  countryName,
                  textAlign: TextAlign.center,
                  style: kCountryTextStyle,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '(' + weatherMessage + ')',
                  textAlign: TextAlign.center,
                  style: kWeatherMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
