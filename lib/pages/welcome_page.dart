import 'package:flutter/material.dart';
import 'authentication_page.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Edudito',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff07225E),
              ),
            ),
            Image.asset('assets/welcome_icon.png'),
            _buildWelcomeWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeWidget(context) {
    return Container(
      padding: EdgeInsets.only(left: 33, right: 16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xff07225E),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Text(
            'Welcome',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 24),
          Text(
            'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          SizedBox(height: 50),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildContainerButton(
                    context,
                    text: 'Sign In',
                    color: Color(0xffF8DE44),
                    state: Auth.SignIn,
                  ),
                  _buildContainerButton(
                    context,
                    text: 'Sign Up',
                    color: Color(0xffffffff),
                    state: Auth.SignUp,
                  ),
                ],
              )),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildContainerButton(context,
      {String text, Auth state, Color color}) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AuthPage(state),
      )),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 42, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        child: Text(text),
      ),
    );
  }
}
