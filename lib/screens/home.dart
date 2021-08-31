import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cimilosheeg/widgets/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather/weather.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final openWeather = WeatherFactory('a2db19caba495fd4db81fc39f35c01ec');

  Weather? weather;

  bool isLoading = false;

  Future<void> fetchWeather(String cityName) async {
    setState(() => isLoading = !isLoading);
    try {
      Position position = await Geolocator.getCurrentPosition();
      weather = await openWeather.currentWeatherByLocation(
          position.latitude, position.longitude);
    } on SocketException {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No Internet Access!')),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('CimiloSheeg'),
        actions: [
          IconButton(
            onPressed: () {
              fetchWeather('Mombasa');
            },
            icon: Icon(Icons.pin_drop_outlined),
          ),
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchScreen(),
              ),
            ),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Ink(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.8),
                BlendMode.darken,
              ),
              image: CachedNetworkImageProvider(
                'https://i.pinimg.com/originals/7e/b6/6d/7eb66d739c10bc4b32fc8fd45628901f.png',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: weather == null
                ? WelcomeView()
                : WeatherContentView(
                    weather: weather!,
                  ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: Text('CimiloSheeg'),
              content: Text(
                'CimiloSheeg waa Application loogu talogalay in uu kuu sheego CImilada meelweliba aad joogto.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Ok, got it!'),
                ),
              ],
            ),
          );
        },
        child: Icon(Icons.info_outline),
      ),
    );
  }
}
