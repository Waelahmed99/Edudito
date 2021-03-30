import 'package:Edudito/helpers/style_guide.dart';
import 'package:flutter/material.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Progress',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: StyleGuide.mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Text('Plantracker'),
      ),
    );
  }
}
