import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class FetchForecastWeather extends ChangeNotifier {
  String lat = '13.7544238';
  String lon = '100.5017651';
  String city = 'Bangkok';
  int click = 1;
  Map<String, dynamic>? weather;
  final CollectionReference weatherInstance =
      FirebaseFirestore.instance.collection('now_weather');

  final CollectionReference forecastWeather =
      FirebaseFirestore.instance.collection('current_weather');

  Future<void> getCurrentWeatherAndUpdate() async {
    var res = await weatherInstance.where('city', isEqualTo: 'Bangkok').get();
    if (res.docs.isNotEmpty) {
      var data = res.docs[0];
      if (data['dt'] >
          DateTime.now()
              .subtract(Duration(minutes: 10))
              .millisecondsSinceEpoch) {
        return;
      }
    }
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=73b79585cb1465a763185a3620657479'));

    var weather = jsonDecode(response.body);

    var weatherData = weather['main'];
    var weatherDescription = weather['weather'][0];

    try {
      await weatherInstance.doc(city).set({
        'dt': weather['dt'] * 1000,
        'rain': weather['rain']?['1h'],
        'city': city,
        'weather': weatherDescription['main'],
        'humidity': weatherData['humidity'],
        'wind': weather['wind']?['speed'],
        'lat': lat,
        'lon': lon,
        'description': weatherDescription['description'],
        'temperature': weatherData['temp'] - 273.15,
      });
    } catch (e) {
      print('Error : $e');
    }
  }

  Future<void> getForecastWeatherAndUpdate() async {
    var res = await forecastWeather
        .where('city', isEqualTo: 'Bangkok')
        .where('dt',
            isGreaterThanOrEqualTo: DateTime.now().millisecondsSinceEpoch)
        .get();

    if (res.docs.isNotEmpty) {
      var data = res.docs.first;
      if (data['dt'] <
          DateTime.now().millisecondsSinceEpoch) {
        return;
      }
    }

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?cnt=4&lat=$lat&lon=$lon&appid=73b79585cb1465a763185a3620657479'));

    if (response.statusCode == 200) {
      var decoded = jsonDecode(response.body);

      var weatherList = decoded['list'];

      for (var i = 0; i < weatherList.length; i++) {
        CollectionReference weatherInstance =
            FirebaseFirestore.instance.collection('current_weather');
        var weather = weatherList[i];
        var weatherData = weather['main'];
        var weatherDescription = weather['weather'][0];

        var weatherInstanceDoc = weatherInstance.doc('${weather['dt']}000');

        await weatherInstanceDoc.set({
          'dt': weather['dt'] * 1000,
          'pop': weather['pop'],
          'rain': weather['rain']?['3h'],
          'city': city,
          'weather': weatherDescription['main'],
          'humidity': weatherData['humidity'],
          'wind': weather['wind']?['speed'],
          'lat': lat,
          'lon': lon,
          'description': weatherDescription['description'],
          'temperature': weatherData['temp'] - 273.15,
        });
      }
    } else {
      throw Exception('Failed to fetch weather');
    }
  }
}
