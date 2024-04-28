import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future<void> updateLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(StringConstant.is_login) != null) {
      _isLogin = prefs.getBool(StringConstant.is_login)!;
      _isLoading = false;
      notifyListeners();
    }
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(StringConstant.is_login) != null) {
      _isLogin = prefs.getBool(StringConstant.is_login)!;
    }
  }

}