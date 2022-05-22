import 'package:flutter/material.dart';

class WeatherMapBackgroundColor {
  final String condition;
  WeatherMapBackgroundColor({required this.condition});

  static Map<String, List<Color>> weatherAndBackground = {
    "Clouds": [
      Color.fromARGB(255, 51, 102, 255),
      Color.fromARGB(255, 0, 204, 255),
    ],
    "Rain": [
      Color.fromARGB(255, 112, 134, 184),
      Color.fromARGB(255, 186, 220, 227),
    ],
    "Clear": [
      Color.fromARGB(255, 248, 214, 120),
      Color.fromARGB(255, 242, 160, 133),
    ],
    "Thunderstorm": [
      Color.fromARGB(255, 248, 214, 120),
      Color.fromARGB(255, 242, 160, 133),
    ],
    "Drizzle": [
      Color.fromARGB(255, 248, 214, 120),
      Color.fromARGB(255, 242, 160, 133),
    ],
    "Snow": [
      Color.fromARGB(255, 189, 237, 237),
      Color.fromARGB(255, 164, 196, 198),
    ],
    "Mist": [
      Color.fromARGB(255, 155, 157, 157),
      Color.fromARGB(255, 88, 89, 89),
    ],
    "Tornado": [
      Color.fromARGB(255, 155, 157, 157),
      Color.fromARGB(255, 88, 89, 89),
    ]
  };

  List<Color> returnColors() {
    return weatherAndBackground[condition] ??
        [
          Color.fromARGB(255, 51, 102, 255),
          Color.fromARGB(255, 0, 204, 255),
        ];
  }
}
