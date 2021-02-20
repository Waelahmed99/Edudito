import 'package:flutter/cupertino.dart';

class ProviderModel extends ChangeNotifier {
  bool _isLoading;

  get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ProviderModel() {
    _isLoading = false;
  }
}
