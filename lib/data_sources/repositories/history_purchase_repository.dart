import 'package:do_an_mobile/data_sources/api_urls.dart';
import 'package:do_an_mobile/data_sources/repositories/app_repository.dart';
import 'package:http/http.dart' as http;

abstract class HistoryPurchaseRepository {
  Future<String> getHistoryPurchase();
  Future<String> feedback(String productID, String orderID, String childTitle, String comment, double rate);
  Future<String> cancel(String orderID);
}

class HistoryPurchaseRepositoryImpl extends HistoryPurchaseRepository {

  static final shared = HistoryPurchaseRepositoryImpl();

  @override
  Future<String> getHistoryPurchase() {
    String url = '$domainName$historyPurchaseEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, true)
        // .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
          return response.body;
    });
  }

  @override
  Future<String> feedback(String productID, String orderID, String childTitle, String comment, double rate) {
    String url = '$domainName$createFeedbackEP';
    Map<String, dynamic> body = {
      "productId": productID,
      "childTitle": childTitle,
      "orderId": orderID,
      "comment": comment,
      "rate": rate
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.post, url, true, body: body)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
          return response.body;
    });
  }

  @override
  Future<String> cancel(String orderID) {
    String url = '$domainName$cancelProductEP$orderID';
    Map<String, dynamic> body = {
      '' : ''
    };
    return AppRespository.shared
        .sendRequest(RequestMethod.patch, url, true, body: body)
        .timeout(const Duration(seconds: 10))
        .then((http.Response response) {
       return response.body;
    });
  }
}
