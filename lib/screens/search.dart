import 'package:cimilosheeg/widgets/weather_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter country or city name',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() => isLoading = true);
                      Future.delayed(Duration(seconds: 5), () {
                        setState(() => isLoading = false);
                      });
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(child: WeatherContentView()),
          ],
        ),
      ),
    );
  }
}
