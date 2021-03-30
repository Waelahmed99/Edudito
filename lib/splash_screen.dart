import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/helpers/utils.dart';
import 'package:Edudito/screens/pages.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// [todo] Fetch data and load login or home screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        Duration(seconds: 2),
        () async {
          bool isAuth = await Utils.provider(context, listen: false).isAuth();
          return Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => isAuth ? Pages() : WelcomePage(),
              ),
              (Route<dynamic> route) => false);
        },
      );
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: 50.0,
                      //   child: Icon(
                      //     Icons.shopping_cart,
                      //     color: Colors.greenAccent,
                      //     size: 50.0,
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'Edudito',
                        style: TextStyle(
                          color: StyleGuide.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'Your learning environment',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: StyleGuide.mainColor),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
