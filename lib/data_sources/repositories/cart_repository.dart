import 'package:do_an_mobile/data_sources/api_urls.dart';
import 'package:do_an_mobile/data_sources/repositories/app_repository.dart';
import 'package:http/http.dart' as http;

abstract class CartRepository {
  Future<String> getProductCart();
}

class CartRepositoryImpl extends CartRepository {
  static final shared = CartRepositoryImpl();

  @override
  Future<String> getProductCart() {
    String url = '$domainName$cartEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, true)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
      return response.body;
    }).catchError((onError) {
      throw Exception(onError);
    });
  }

  Future<String> addProductToCart(String id, String childTitle, int quantity) {
    String url = '$domainName$addCartEP';
    Map<String, dynamic> body = {
      'id': id,
      'childTitle': childTitle,
      'quantity': quantity
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.post, url, true, body: body)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
          return response.body;
    }).catchError((onError) {
      throw Exception(onError);
    });
  }
}
