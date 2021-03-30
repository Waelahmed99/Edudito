import 'package:Edudito/helpers/line_chart.dart';
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'My learning',
                  style: TextStyle(
                    color: StyleGuide.mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Container(
                width: 300,
                height: 170,
                child: LineChartSample2(),
              ),
              SizedBox(height: 32),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'My courses',
                  style: TextStyle(
                    color: StyleGuide.mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
