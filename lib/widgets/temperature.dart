import 'package:flutter/material.dart';
import 'package:weather_app/widgets/weather_icon.dart';

class TemperatureWidget extends StatefulWidget {
  const TemperatureWidget(
      {Key? key,
      required this.city,
      required this.currentTimeStamps,
      required this.temperature,
      required this.weather})
      : super(key: key);

  final String city;
  final double temperature;
  final String weather;
  final DateTime currentTimeStamps;

  @override
  State<TemperatureWidget> createState() => _TemperatureWidgetState();
}

class _TemperatureWidgetState extends State<TemperatureWidget> {
  Map<String, double> tempMap = {
    'celcius': 0,
    'fahrenheit': 0,
  };
  var tempType = 'celcius';

  void initState() {
    tempMap['celcius'] = widget.temperature;
    tempMap['fahrenheit'] = widget.temperature * 1.8 + 32;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Container(
      constraints: BoxConstraints(minWidth: 250, maxWidth: 400),
      padding: EdgeInsets.all(height / 40),
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(widget.city,
                  style: TextStyle(fontSize: height / 40, color: Colors.white)),
            ),
            Container(
              margin: EdgeInsets.only(top: height / 40),
              height: height / 5,
              child: WeatherIcon(
                  height: height,
                  condition: widget.weather,
                  isDay: widget.currentTimeStamps.hour < 18 &&
                      widget.currentTimeStamps.hour > 5),
            ),
            Container(
              width: width / 2,
              height: height / 6,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              tempType == 'celcius'
                                  ? tempType = 'fahrenheit'
                                  : tempType = 'celcius';
                            });
                          },
                          icon: Icon(Icons.swap_horiz_outlined,
                              color: Colors.white,
                              size: height / 30)),
                    ],
                  ),
                  Center(
                    child: Text(
                        '${tempType == 'fahrenheit' ? (widget.temperature * 1.8 + 32).toStringAsFixed(0) : widget.temperature.toStringAsFixed(0)}\u00B0${tempType == 'fahrenheit' ? 'F' : 'C'}',
                        style: TextStyle(fontSize: height / 10)),
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
