import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

const apiKey = 'bb6b801733ae870e8ac41adc19b94803';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void getData() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    String data = response.body;

    var longitude = jsonDecode(data)['coord']['lon'];
    var weatherDescription = jsonDecode(data)['weather'][0]['description'];
    print(longitude);
    print(weatherDescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
