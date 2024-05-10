import 'package:do_an_mobile/data_sources/api_urls.dart';
import 'package:do_an_mobile/data_sources/repositories/app_repository.dart';
import 'package:http/http.dart' as http;

abstract class CheckOutRepository {
  Future<String> checkoutSuccess(String fullname, String phone, String address, String discountID, List products);
  Future<String> getDiscount();
}

class CheckOutRepositoryImpl extends CheckOutRepository {

  static final shared = CheckOutRepositoryImpl();

  @override
  Future<String> checkoutSuccess(String fullname, String phone, String address, String discountID, List products) {
    String url = '$domainName$checkoutSuccessEP';
    Map<String, dynamic> body = {
      "fullName": fullname,
      "phone":phone,
      "address": address,
      "discountId": discountID,
      "products": products
    };

    return AppRespository.shared
        .sendRequest(RequestMethod.post, url, true, body: body)
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
          return response.body;
    });
  }

  @override
  Future<String> getDiscount() {
    String url = '$domainName$discountEP';
    return AppRespository.shared
        .sendRequest(RequestMethod.get, url, true)
        .timeout(const Duration(seconds: 15))
        .then((http.Response response) {
          return response.body;
    });
  }

}