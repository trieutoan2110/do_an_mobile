import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class APIManager {
  static final shared = APIManager();

  Future fetchDataUser() async {
    try {
      String url = 'https://ecommerce-rho-gray.vercel.app/api/v1/admin/accounts';
      final uri = Uri.parse(url);
      final Map<String, String> headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer 8UKlKbJQcjtB4QBxamk0',
      };
      final response = await http.get(uri, headers: headers);
      final json = jsonDecode(response.body);
      print(json);
    } catch (e) {
      rethrow;
    }
  }
}