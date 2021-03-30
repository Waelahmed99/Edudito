import 'package:Edudito/helpers/provider.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/screens/enrolled_environment.dart';
import 'package:Edudito/screens/plan_tracker.dart';
import 'package:Edudito/screens/progress_page.dart';
import 'package:Edudito/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'my_enivronment_page.dart';

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
                      image: AssetImage('assets/physics.png'),
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
                    SizedBox(width: 3),
                    Text('Newbie'),
                  ],
                ),
                SizedBox(height: 15),
                _menuItem(context,
                    icon: 'progress',
                    text: 'Progress',
                    navigator: ProgressPage()),
                _menuItem(context,
                    icon: 'material',
                    text: 'Enrolled environments',
                    navigator: EnrolledEnvironments()),
                _menuItem(context,
                    icon: 'my_environment',
                    text: 'My environment',
                    navigator: MyEnvironmentPage()),
                _menuItem(context,
                    icon: 'plantracker',
                    text: 'Plantracker',
                    navigator: PlanTrackerPage()),
                _menuItem(context,
                    icon: 'logout', text: 'Logout', logout: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    String icon,
    String text,
    bool logout = false,
    dynamic navigator,
  }) {
    final authprovider = Provider.of<ProviderModel>(context);

    return GestureDetector(
      onTap: () {
        if (logout) {
          authprovider.firebaseAuth.signOut();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => SplashScreen()),
              (Route<dynamic> route) => false);
        } else
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => navigator,
          ));
      },
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 18).copyWith(bottom: 11),
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffF2F6FB),
        ),
        child: Row(
          children: <Widget>[
            Image.asset('assets/$icon.png', width: 22),
            SizedBox(width: 8),
            Text(text),
            Spacer(),
            Icon(LineAwesomeIcons.angle_right, size: 20),
          ],
        ),
      ),
    );
  }
}
