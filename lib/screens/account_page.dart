import 'package:Edudito/helpers/style_guide.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class AccountPage extends StatelessWidget {
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
          'Profile',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: StyleGuide.mainColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/physics.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Hana Joe',
                  style: TextStyle(
                    fontSize: 19,
                    color: StyleGuide.mainColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/location.png',
                      width: 14,
                    ),
                    SizedBox(width: 3),
                    Text('London'),
                  ],
                ),
                SizedBox(height: 15),
                _menuItem(icon: LineAwesomeIcons.trophy, text: 'Progress'),
                _menuItem(icon: LineAwesomeIcons.trophy, text: 'Material'),
                _menuItem(
                    icon: LineAwesomeIcons.trophy, text: 'My environment'),
                _menuItem(icon: LineAwesomeIcons.trophy, text: 'Plantracker'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem({
    IconData icon,
    String text,
  }) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffF2F6FB),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 20),
          SizedBox(width: 5),
          Text(text),
          Spacer(),
          Icon(LineAwesomeIcons.angle_right, size: 20),
        ],
      ),
    );
  }
}
