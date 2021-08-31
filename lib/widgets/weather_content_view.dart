import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherContentView extends StatelessWidget {
  const WeatherContentView({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: '${weather.areaName}, ${weather.country}',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w300,
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: '\nUpdated: 11:09 EAT, 30/08/2021',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: weather.temperature!.celsius!.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
            ),
            children: [
              TextSpan(
                text: ' °C',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w100,
                ),
              ),
              TextSpan(
                text: '\n ${weather.weatherDescription}',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w300,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.refresh),
        ),
      ],
    );
  }
}
