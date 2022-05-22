import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class Infobar extends StatelessWidget {
  const Infobar({Key? key, this.rain = 0, this.wind = 0, this.humidity = 0})
      : super(key: key);

  final double rain;
  final double wind;
  final double humidity;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: height / 12,
            child: Column(
              children: [
                Icon(WeatherIcons.raindrop, color: Colors.white, size: 25),
                SizedBox(height: 15),
                Text(
                  '${rain.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            )),
        Container(
            width: height / 12,
            child: Column(
              children: [
                Icon(WeatherIcons.wind, color: Colors.white, size: 25),
                SizedBox(height: 15),
                Text(
                  '${wind.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            )),
        Container(
            width: height / 12,
            child: Column(
              children: [
                Icon(WeatherIcons.humidity, color: Colors.white, size: 20),
                SizedBox(height: 20),
                Text(
                 '${humidity.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ))
      ],
    );
  }
}
