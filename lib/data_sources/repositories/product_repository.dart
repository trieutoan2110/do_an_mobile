
import 'package:http/http.dart' as http;

import '../api_urls.dart';
import 'app_repository.dart';

abstract class ProductRepository {
  Future<String> getProductCategory();
  Future<String> getProductBestSeller();
  Future<String> getProductFeatured();
  Future<String> getProductBestRate();
}

class ProductReposityImpl extends ProductRepository {
  static final shared = ProductReposityImpl();

  @override
  Future<String> getProductBestRate() {
    String url = '$domainName$productBestRateEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, false)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
      return response.body;
    }).catchError((onError) {
      throw Exception('failed to load data error');
    });
  }

  @override
  Future<String> getProductBestSeller() {
    String url = '$domainName$productBestSellerEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, false)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
      //print(response.body);
      return response.body;
    }).catchError((onError) {
      throw Exception('failed to load data error');
    });
  }

  @override
  Future<String> getProductCategory() {
    String url = '$domainName$productCategoryEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, false)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
      return response.body;
    }).catchError((onError) {
      throw Exception('failed to load data error');
    });
  }

  @override
  Future<String> getProductFeatured() {
    String url = '$domainName$productFeaturedEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, false)
        .timeout(const Duration(seconds: 30))
        .then((http.Response response) {
      return response.body;
    }).catchError((onError) {
      throw Exception('failed to load data error');
    });
  }

}