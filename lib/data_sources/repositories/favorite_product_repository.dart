import 'package:do_an_mobile/data_sources/api_urls.dart';
import 'package:do_an_mobile/data_sources/repositories/app_repository.dart';
import 'package:http/http.dart' as http;

abstract class FavoriteRepository {
  Future<String> getListFavorite();
  Future<String> addProductInListFavorite(String id);
  Future<String> deleteProductFromListFavorite(String id);
}

class FavoriteRepositoryImpl extends FavoriteRepository {
  static final shared = FavoriteRepositoryImpl();

  @override
  Future<String> addProductInListFavorite(String id) {
    String url = '$domainName$addFavoriteEP$id';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, true)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
      return response.body;
    });
  }

  @override
  Future<String> deleteProductFromListFavorite(String id) {
    String url = '$domainName$deleteFavoriteEP$id';
    return AppRespository.shared
        .sendRequest(RequestMethod.delete, url, true)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
      return response.body;
    });
  }

  @override
  Future<String> getListFavorite() {
    String url = '$domainName$favoriteEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, true)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
          return response.body;
    });
  }
}