import 'package:Edudito/helpers/utils.dart';
import 'package:Edudito/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// [todo] Fetch data and load login or home screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>
                  Utils.provider(context).isAuth() ? HomePage() : WelcomePage(),
            ),
            (Route<dynamic> route) => false),
      );
    });
    return Scaffold(
      body: Center(
        child: Text('Splash screen'),
      ),
    );
  }
}
