import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'helpers/strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Poppins'),
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}
