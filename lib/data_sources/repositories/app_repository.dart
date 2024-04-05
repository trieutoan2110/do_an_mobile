import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestMethod {
  static const post = 'POST';
  static const get = 'GET';
  static const patch = 'PATCH';
  static const put = 'PUT';
  static const delete = 'DELETE';
}

class AppRespository {

  static final AppRespository shared = AppRespository();

  Future<http.Response> sendRequest(method,String url, bool hasToken, {Object? body}) async {
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    if (hasToken == true) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String token = pref.getString('token')!;
      header[HttpHeaders.authorizationHeader] = 'Bearer $token';
    }

    if (method == RequestMethod.get) {
      return http.get(Uri.parse(url), headers: header);
    }
    if (method == RequestMethod.post) {
      return http.post(Uri.parse(url), headers: header, body: jsonEncode(body));
    }
    return http.get(Uri.parse(url), headers: header);
  }
}