import 'dart:convert';
import 'dart:io';

import 'package:do_an_mobile/managers/api_urls.dart';
import 'package:do_an_mobile/managers/repositories/app_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<String> logout();
  Future<String> register(String fullname, String email, String password);
  Future<String> forgotEmail(String email);
  Future<String> forgotOtp(String email, String otp);
}

class AuthRepositoryImpl extends AuthRepository {
  static final shared = AuthRepositoryImpl();

  @override
  Future<String> login(String email, String password) async {
    String url = '$domainName$loginEP';
    Map<String, dynamic> body = {
      'email': email,
      'password': password
    };
    return AppRespository.shared.sendRequest (
        RequestMethod.post,
        url,
        false,
        body: body
    ).timeout(const Duration(seconds: 30))
    .then((http.Response response) {
      return response.body;
    }).catchError((error) {
      throw Exception('failed to load data error');
    });
  }

  @override
  Future<String> logout() async {
    String url = '$domainName$logoutEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, true)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
      return response.body;
    }).catchError((error) {
      throw Exception('failed to load data error');
    });
  }

  @override
  Future<String> register(String fullname, String email, String password) async {
    String url = '$domainName$registerEP';
    final Map<String, dynamic> body = {
      'fullname': fullname,
      'email': email,
      'password': password
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.post, url, false, body: body)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) => response.body)
        .catchError((error) {
      throw Exception('failed to load data $error');
    });
  }

  @override
  Future<String> forgotEmail(String email) async {
    String url = '$domainName$forgotEmailEP';
    final Map<String, dynamic> body = {
      'email': email
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.post, url, false, body: body)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) => response.body)
        .catchError((onError) {
      throw Exception('failed to load data $onError');
    });
  }

  @override
  Future<String> forgotOtp(String email, String otp) async {
    String url = '$domainName$forgotOTPEP';
    Map<String, dynamic> body = {
      'email': email,
      'otp': otp
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.post, url, false, body: body)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) => response.body)
        .catchError((onError) {
      throw Exception('failed to load data $onError');
    });
  }
}