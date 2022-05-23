import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/widgets/weather_icon.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherSeries extends StatefulWidget {
  WeatherSeries({
    Key? key,
    required this.currentTimeStamps,
    required this.weather,
  }) : super(key: key);

  final DateTime currentTimeStamps;
  final String weather;

  @override
  State<WeatherSeries> createState() => _WeatherSeriesState();
}

class _WeatherSeriesState extends State<WeatherSeries> {
  final CollectionReference weatherSeries =
      FirebaseFirestore.instance.collection('current_weather');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    return FutureBuilder(
        future: weatherSeries
            .where('city', isEqualTo: 'Bangkok')
            .where('dt',
                isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
            .limit(4)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Text("Something went wrong");
          }

          if (snapshot.hasData) {
            return Container(
                height: height / 5,
                width: height / 2.75,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (ctx, index) => Container(
                          padding: EdgeInsets.all(15.0),
                          child: Column(children: [
                            Text(DateFormat.jm().format(
                                new DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data!.docs[index]['dt']))),
                            WeatherIcon(
                              height: height / 4,
                              condition: snapshot.data!.docs[index]['weather'],
                            ),
                            SizedBox(height: 10),
                            Text(
                                '${(snapshot.data!.docs[index]['temperature']).toStringAsFixed(0)}\u00B0'),
                          ]),
                        )));
          }

          return CircularProgressIndicator();
        });
  }
}
