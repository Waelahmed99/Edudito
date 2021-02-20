import 'package:Edudito/pages/authentication_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProviderModel extends ChangeNotifier {
  bool _isLoading;
  FirebaseAuth firebaseAuth;

  get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ProviderModel() {
    firebaseAuth = FirebaseAuth.instance;
    _isLoading = false;
  }

  Future<String> authenticate(Map<String, String> data,
      {Auth state = Auth.SignIn}) async {
    if (state == Auth.SignUp) {
      if (data['password'] != data['repassword'])
        return 'Password doesn\'t match';
    }

    if (!data.containsKey('email') || data['email'].isEmpty)
      return 'Please enter your email';
    if (!data.containsKey('password') || data['password'].isEmpty)
      return 'Please enter your password';

    UserCredential user;
    try {
      if (state == Auth.SignIn)
        user = await firebaseAuth.signInWithEmailAndPassword(
            email: data['email'], password: data['password']);
      else
        user = await firebaseAuth.createUserWithEmailAndPassword(
            email: data['email'], password: data['password']);
    } catch (e) {
      /// [todo] parse error message.
      print(e.message);
      return e.message;
    }

    /// [todo] save user credential.
    return 'success';
  }
}
