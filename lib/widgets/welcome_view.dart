import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Kusoo dhawaaw',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w200,
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: '\nCimiloSheeg App⛈️',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
