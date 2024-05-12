import 'package:http/http.dart' as http;
import '../api_urls.dart';
import 'app_repository.dart';

abstract class AuthRepository {
  Future<String> login(String email, String password);
  Future<String> logout();
  Future<String> register(String fullname, String email, String password);
  Future<String> forgotEmail(String email);
  Future<String> forgotOtp(String email, String otp);
  Future<String> editProfile(String email, String username, String address, String phone, String imageUrl);
  Future<String> uploadImage(String avatarUrl);
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
      'fullName': fullname,
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

  @override
  Future<String> editProfile(String email, String username, String address, String phone, String imageUrl) {
    String url = '$domainName$editProfileEP';
    Map<String, dynamic> body = {
      "email": email,
      "fullName": username,
      "address": address,
      "phone": phone,
      'avatar': imageUrl
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.patch, url, true, body: body)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
          return response.body;
    });
  }

  @override
  Future<String> uploadImage(String avatarUrl) {
    String url = '$domainName$uploadImageEP';
    Map<String, dynamic> body = {
      'avatar': avatarUrl
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.patch, url, true, body: body)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
      return response.body;
    });
  }
}