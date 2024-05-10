import 'dart:convert';

import 'package:do_an_mobile/data_sources/repositories/checkout_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/home_model/discount_model.dart';
class CheckOutProvider extends ChangeNotifier {
  List<Discount> _listDiscount = [];
  List<Discount> get listDiscount => _listDiscount;

  bool _isloading = true;
  bool get isLoading => _isloading;

  Future getListDiscount() async {
    CheckOutRepositoryImpl.shared.getDiscount()
    .timeout(const Duration(seconds: 15))
        .then((value) {
      DiscountModel discountModel = DiscountModel.fromJson(jsonDecode(value));
      _listDiscount = discountModel.listDiscount;
      _isloading = false;
      notifyListeners();
    }).catchError((onError) {
      _isloading = false;
      notifyListeners();
    });
  }
}