import 'package:Edudito/helpers/line_chart.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 12),
                    ProgressItem(
                      themeIdx: 0,
                      progress: 20,
                    ),
                    SizedBox(height: 12),
                    ProgressItem(
                      themeIdx: 1,
                      progress: 100,
                    ),
                    SizedBox(height: 12),
                    ProgressItem(
                      themeIdx: 2,
                      progress: 65,
                    ),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressItem extends StatelessWidget {
  final List<Color> colors = [
    Color(0xff9966CC),
    Color(0xffF9BF3C),
    Color(0xff39C0E0),
  ];
  final int themeIdx;
  final double progress;

  ProgressItem({this.themeIdx, this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors[themeIdx],
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
      width: MediaQuery.of(context).size.width,
      // height: 100,
      child: Row(
        children: [
          Icon(LineAwesomeIcons.trophy, color: Colors.white),
          SizedBox(width: 12),
          Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Intro to GUI with python',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      'Progress ${progress.floor()}%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: progress / 100.0,
                  backgroundColor: Color(0xffC4A6E1),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                child: Text(
                  '12 Sep',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              Text(
                'Enrolled',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
