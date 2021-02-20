import 'package:Edudito/helpers/strings.dart';
import 'package:Edudito/helpers/style_guide.dart';
import 'package:Edudito/helpers/utils.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/no_glow_behavior.dart';

enum Auth { SignIn, SignUp }

class AuthPage extends StatefulWidget {
  final Auth initialAuth;

  const AuthPage(this.initialAuth);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Auth state;
  List<String> labels;
  List<String> mapKeys;
  Map<String, String> authData;

  @override
  void initState() {
    labels = ['Email', 'Password', 'Confirm password'];
    mapKeys = ['email', 'password', 'repassword'];
    authData = {};
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
              style: TextStyle(fontSize: 24, color: Colors.white),
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
      padding: EdgeInsets.symmetric(horizontal: 30),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          topLeft: Radius.circular(35),
        ),
      ),
      child: ScrollConfiguration(
        behavior: NoGlowBehaviour(),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 170,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(height: 60),
                for (int i = 0; i < (isSignIn ? 2 : 3); i++) _buildTextField(i),
                SizedBox(height: 16),
                _buildAuthButton(
                  text: isSignIn ? Strings.signIn : Strings.signUp,
                  fillColor: StyleGuide.secondaryColor,
                  onTap: authenticateUserWithEmail,
                ),
                SizedBox(height: 10),
                _buildAuthButton(text: 'Google', fillColor: Color(0xffE64343)),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 25),
                    alignment: Alignment.bottomCenter,
                    child: _buildChangeAuth(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void authenticateUserWithEmail() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Signing you in'),
        content: FutureBuilder(
          future: Utils.provider(context).authenticate(authData, state: state),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) return Text('Please be patient');
            if (snapshot.data == 'success')
              WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => MyApp(),
                      ),
                      (_) => false));
            return Text(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget _buildChangeAuth() {
    return GestureDetector(
      onTap: () => changeAuthState(),
      child: RichText(
        text: new TextSpan(
          style: new TextStyle(fontSize: 14.0, color: Colors.black),
          children: <TextSpan>[
            new TextSpan(
                text:
                    isSignIn ? Strings.switchToSignUp : Strings.switchtoSignIn),
            new TextSpan(
                text: '  ${isSignIn ? Strings.signUp : Strings.signIn}',
                style: new TextStyle(
                    color: StyleGuide.accentColor,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthButton({Function onTap, String text, Color fillColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: fillColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 4,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: Text(text,
            style: TextStyle(
              color: StyleGuide.mainColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  Widget _buildTextField(int idx) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            labels[idx],
            style: TextStyle(fontSize: 13, color: StyleGuide.mainColor),
          ),
        ),
        Container(
          height: 45,
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Color(0xffF1F1F2),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 0,
                blurRadius: 4,
                offset: Offset(1, 3),
              ),
            ],
          ),
          child: TextFormField(
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 18.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent, width: 18.0),
              ),
            ),
            onChanged: (value) => authData[mapKeys[idx]] = value,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
