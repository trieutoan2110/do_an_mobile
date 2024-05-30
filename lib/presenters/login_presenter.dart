import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data_sources/constants.dart';
import '../data_sources/repositories/auth_repository.dart';
import '../models/auth_model.dart';

abstract class LoginViewContract {
  void onLoginComplete();
  void onLoginError(String messages);
}

class LoginPresenter {
  final LoginViewContract? _view;

  LoginPresenter(this._view);

  Future login(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AuthRepositoryImpl.shared.login(email, password).then((value) {
      AuthModel authModel = AuthModel.fromJson(jsonDecode(value));
      if (authModel.code == 200) {
        _setUserInfor(
            authModel.token,
            authModel.user!.fullName,
            authModel.user!.avatar,
            authModel.user!.phone,
            authModel.user!.rank,
            authModel.user!.address ?? '',
            authModel.user!.email);
        prefs.setBool(StringConstant.is_login, true);
        _view!.onLoginComplete();
      } else {
        _view!.onLoginError(authModel.message);
      }
    });
  }

  Future _setUserInfor(
      String? token, String? username,
      String? avatar, String? phone,
      String? ranking, String? address, String? email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(StringConstant.key_token, token ?? '');
    prefs.setString(StringConstant.phone_number, phone?? '');
    prefs.setString(StringConstant.username, username?? '');
    prefs.setString(StringConstant.address, address?? '');
    prefs.setString(StringConstant.ranking, ranking?? '');
    prefs.setString(StringConstant.avatarUrl, avatar?? '');
    prefs.setString(StringConstant.email, email?? '');
  }
}