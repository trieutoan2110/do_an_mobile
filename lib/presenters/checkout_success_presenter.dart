import 'dart:convert';

import 'package:do_an_mobile/models/home_model/checkout_success_model.dart';

import '../data_sources/repositories/checkout_repository.dart';

abstract class CheckOutSuccessViewContract {
  void checkOutComplete();
  void checkOutError(String msg);
}

class CheckOutSuccessPresenter {
  CheckOutSuccessViewContract? _view;
  CheckOutSuccessPresenter(this._view);

  Future checkoutSuccess(String fullname, String phone,
      String address, String discountID, List products) async {
    CheckOutRepositoryImpl.shared
        .checkoutSuccess(fullname, phone, address, discountID, products)
        .then((value) {
      CheckOutSuccessModel model = CheckOutSuccessModel.fromJson(jsonDecode(value));
      if (model.code == 200) {
        _view!.checkOutComplete();
      } else {
        _view!.checkOutError(model.message);
      }
    }).catchError((onError) {
      _view!.checkOutError(onError);
    });
  }
}