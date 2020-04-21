import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  fontFamily: 'RobotoMono',
  fontSize: 80.0,
  color: Colors.black,
);

const kMessageTextStyle = TextStyle(
  fontFamily: 'RobotoMono',
  fontSize: 50.0,
  color: Colors.black,
);

const kWeatherMessageTextStyle = TextStyle(
  fontFamily: 'RobotoMono',
  fontSize: 20.0,
  color: Colors.black,
);

const kCountryTextStyle = TextStyle(
  fontFamily: 'RobotoMono',
  fontSize: 25.0,
  color: Colors.black,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  fontFamily: 'RobotoMono',
  color: Colors.black,
);

const kConditionTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.grey,
  icon: Icon(
    Icons.location_city,
    color: Colors.black,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.black,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(8.0),
    ),
    borderSide: BorderSide.none,
  ),
);
