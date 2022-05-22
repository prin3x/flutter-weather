import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherIcon extends StatelessWidget {
  WeatherIcon({Key? key, required this.height, required this.condition, this.isDay = true})
      : super(key: key);
  final double height;
  final String condition;
  final bool isDay;
  final Map<String, dynamic> weatherWithIcon = {
    "Clouds": WeatherIcons.day_sunny_overcast,
    "Rain": WeatherIcons.rain,
    "Clear": WeatherIcons.day_sunny,
    "Thunderstorm": WeatherIcons.thunderstorm,
    "Drizzle": WeatherIcons.rain_mix,
    "Snow": WeatherIcons.snow,
    "Mist": WeatherIcons.fog,
    "Tornado": WeatherIcons.tornado
  };

  final Map<String, dynamic> nightWeatherWithIcon = {
    "Clouds": WeatherIcons.night_cloudy,
    "Rain": WeatherIcons.night_rain,
    "Clear": WeatherIcons.night_clear,
    "Thunderstorm": WeatherIcons.night_thunderstorm,
    "Drizzle": WeatherIcons.night_rain_mix,
    "Snow": WeatherIcons.night_snow,
    "Mist": WeatherIcons.night_fog,
    "Tornado": WeatherIcons.tornado
  };

  @override
  Widget build(BuildContext context) {
    var mapIcon = isDay ? weatherWithIcon[condition] : nightWeatherWithIcon[condition] ?? WeatherIcons.day_sunny;
    return Icon(mapIcon,
        color: Colors.white, size: height / 6);
  }
}
