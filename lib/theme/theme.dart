import 'package:flutter/material.dart';

var appTheme = ThemeData(
  primaryColor:  Color.fromARGB(255, 77, 176, 209),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
        bodyText2: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    button: TextStyle(
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 80,
      color: Colors.white,
    ),
    headline2: TextStyle(
      fontSize: 80,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    headline3: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
      color: Colors.grey,
    ),
  ),
);
