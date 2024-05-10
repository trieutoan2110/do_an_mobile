import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/models/user_infor_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AuthProvider extends ChangeNotifier {
  bool _isLogin = false;
  bool get isLogin => _isLogin;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  UserInfor? _userInfor;
  UserInfor? get userInfor => _userInfor;

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
    // prefs.clear();
    if (prefs.getBool(StringConstant.is_login) != null) {
      _isLogin = prefs.getBool(StringConstant.is_login)!;
      notifyListeners();
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setBool(StringConstant.is_login, false);
    notifyListeners();
  }

  void getUserInfor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(StringConstant.key_token) ?? '';
    String username = prefs.getString(StringConstant.username) ?? '';
    String avatar = prefs.getString(StringConstant.avatarUrl)?? '';
    String phone = prefs.getString(StringConstant.phone_number) ?? '';
    String rank = prefs.getString(StringConstant.ranking) ?? '';
    String address = prefs.getString(StringConstant.address) ?? '';
    String email = prefs.getString(StringConstant.email) ?? '';
    _userInfor = UserInfor(token: token, username: username, avatar: avatar, phone: phone, address: address, ranking: rank, email: email);
  }
}