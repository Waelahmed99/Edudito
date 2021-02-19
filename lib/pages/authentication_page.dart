import 'package:Edudito/helpers/strings.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:flutter/material.dart';

enum Auth { SignIn, SignUp }

class AuthPage extends StatefulWidget {
  final Auth initialAuth;

  const AuthPage(this.initialAuth);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Auth state;

  @override
  void initState() {
    state = widget.initialAuth;
    super.initState();
  }

  get isSignIn => state == Auth.SignIn;

  void changeAuthState() =>
      setState(() => state = (isSignIn ? Auth.SignUp : Auth.SignIn));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: StyleGuide.mainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Text(
              isSignIn ? Strings.signInMessage : Strings.signUpMessage,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 30),
            Expanded(child: _buildForm(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          topLeft: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 60),
          Text(isSignIn ? Strings.signIn : Strings.signUp),
        ],
      ),
    );
  }
}
