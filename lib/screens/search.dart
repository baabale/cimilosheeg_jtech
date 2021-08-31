import 'dart:io';

import 'package:cimilosheeg/widgets/weather_content_view.dart';
import 'package:cimilosheeg/widgets/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather/weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final openWeather = WeatherFactory('a2db19caba495fd4db81fc39f35c01ec');

  bool isLoading = false;
  Weather? weather;

  String cityName = '';

  Future<void> fetchWeather() async {
    setState(() => isLoading = !isLoading);
    try {
      weather = await openWeather.currentWeatherByCityName(cityName);
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No Internet Access!'),
          duration: Duration(seconds: 20),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    setState(() => isLoading = !isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (newVal) {
                  cityName = newVal;
                },
                onSubmitted: (newVal) {
                  cityName = newVal;
                  fetchWeather();
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter country or city name',
                  suffixIcon: IconButton(
                    onPressed: () {
                      fetchWeather();
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: weather == null
                  ? WelcomeView()
                  : WeatherContentView(weather: weather!),
            ),
          ],
        ),
      ),
    );
  }
}
