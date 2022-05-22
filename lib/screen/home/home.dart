import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/services/fetch_forecast_weather.dart';
import 'package:weather_app/services/weather_background.dart';
import 'package:weather_app/widgets/infobar.dart';
import 'package:weather_app/widgets/temperature.dart';
import 'package:weather_app/widgets/weather_series.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime currentTimeStamps = DateTime.now();
  final spinkit = SpinKitRotatingCircle(
    color: Color.fromARGB(255, 245, 138, 31),
    size: 50.0,
  );

  String lat = '13.7544238';
  String lon = '100.5017651';
  String city = 'Bangkok';

  final CollectionReference nowWeather =
      FirebaseFirestore.instance.collection('now_weather');

  FetchForecastWeather weatherFetcher = FetchForecastWeather();

  void initState() {
    weatherFetcher.getCurrentWeatherAndUpdate();
    weatherFetcher.getForecastWeatherAndUpdate();
    Timer.periodic(const Duration(minutes: 10), (Timer timer) {
      weatherFetcher.getCurrentWeatherAndUpdate();
    });
    Timer.periodic(const Duration(hours: 3), (Timer timer) {
      // weatherFetcher.getForecastWeatherAndUpdate();
    });
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      updateTimer(timer);
    });

    super.initState();
  }

  void updateTimer(Timer t) {
    setState(() {
      currentTimeStamps = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    return Scaffold(
        body: StreamBuilder(
            stream: nowWeather.where('city', isEqualTo: 'Bangkok').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
                return Text("Something went wrong");
              }
              if (snapshot.hasData) {
                var data = snapshot.data!.docs[0];
                var weatherMapping =
                    WeatherMapBackgroundColor(condition: data['weather']);
                var colorList = weatherMapping.returnColors();
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: colorList,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  constraints:
                      BoxConstraints(minWidth: height / 4, maxWidth: 1500),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat.yMMMEd().format(currentTimeStamps),
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                DateFormat.Hm().format(currentTimeStamps),
                                style: Theme.of(context).textTheme.headline1,
                              ),
                              TemperatureWidget(
                                currentTimeStamps: currentTimeStamps,
                                city: weatherFetcher.city,
                                temperature: data['temperature'] ?? 30,
                                weather: data['weather'] ?? 'sunny',
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(21, 255, 255, 255),
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                child: Infobar(
                                    rain: data['rain'] ?? 0,
                                    wind: data['wind'] ?? 0,
                                    humidity: data['humidity'] ?? 0),
                              ),
                              Container(
                                margin: new EdgeInsets.only(top: 24.0),
                                child: WeatherSeries(
                                    weather: data['weather'] ?? 'Clear',
                                    currentTimeStamps: currentTimeStamps),
                              )
                            ]),
                      ],
                    ),
                  ),
                );
              }
              return Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 22, 80, 240),
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: spinkit);
            }));
  }
}
