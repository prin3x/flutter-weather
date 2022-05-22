import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/firebase_options.dart';
import 'package:weather_app/screen/home/home.dart';
import 'package:weather_app/theme/theme.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: HomeScreen(),
    theme: appTheme,
  ));
}
