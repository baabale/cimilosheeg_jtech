import 'package:cimilosheeg/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(CimiloSheeg());
}

class CimiloSheeg extends StatelessWidget {
  const CimiloSheeg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
