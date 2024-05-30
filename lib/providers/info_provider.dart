import 'dart:convert';

import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/repositories/history_purchase_repository.dart';
import 'package:do_an_mobile/models/home_model/history_purchase_model.dart';
import 'package:flutter/foundation.dart';

class InforProvider extends ChangeNotifier {

  HistoryPurchaseModel? _historyPurchaseModel;

  List<HistoryPurchase> _listHistoryPurchase = [];
  List<HistoryPurchase> get listHistoryPurchase => _listHistoryPurchase;

  // List<Product> _listProduct = [];
  // List<Product> get listProduct => _listProduct;

  List<Product> _listToPay = [];
  List<Product> get listToPay => _listToPay;

  List<Product> _listToShip = [];
  List<Product> get listToShip => _listToShip;

  List<Product> _listToReceive = [];
  List<Product> get listToReceive => _listToReceive;

  List<Product> _listToRate = [];
  List<Product> get listToRate => _listToRate;

  List<Product> _listCompleted = [];
  List<Product> get listCompleted => _listCompleted;

  List<Product> _listCancel = [];
  List<Product> get listCancel => _listCancel;

  List<Product> _listReturnRefund = [];
  List<Product> get listReturnRefund => _listReturnRefund;

  List<String> _listOrderIDByProduct = [];
  List<String> get listOrderIDByProduct => _listOrderIDByProduct;

  List<String> _listOrderIDByProductToPay = [];
  List<String> get listOrderIDByProductToPay => _listOrderIDByProductToPay;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  Future getHistoryPurchase() async {
    _isLoading = true;
    HistoryPurchaseRepositoryImpl.shared.getHistoryPurchase().then((value) {
      _historyPurchaseModel = HistoryPurchaseModel.fromJson(jsonDecode(value));
      _listHistoryPurchase = _historyPurchaseModel!.historyPurchase!;
      setListHistoryPurchase();
      _isLoading = false;
      notifyListeners();
    });
  }

  void setListHistoryPurchase() {
    for (var historyPurchase in _listHistoryPurchase) {
      int statusOrder = historyPurchase.statusOrder;
      for (var product in historyPurchase.products) {
        if (statusOrder == 0) {
          _listToPay.add(product);
          _listOrderIDByProductToPay.add(historyPurchase.id);
        } else if (statusOrder == 1) {
          _listToShip.add(product);
        } else if (statusOrder == 2) {
          _listToReceive.add(product);
        } else if (statusOrder == 3) {
          _listCompleted.add(product);
          if (product.statusComment == 1) {
            _listToRate.add(product);
            _listOrderIDByProduct.add(historyPurchase.id);
          }
        } else if (statusOrder == 4) {
          _listCancel.add(product);
        } else {
          _listReturnRefund.add(product);
        }
      }
    }
    // notifyListeners();
  }

  void removeProductFromListToRate(String productID) {
    _listToRate.removeWhere((element) => element.productId == productID);
    notifyListeners();
  }

  void removeProductFromListToPay(int index) {
    _listToPay.removeAt(index);
    // notifyListeners();
  }

  Future cancel(String orderID) async {
    HistoryPurchaseRepositoryImpl.shared.cancel(orderID).then((value) {
      print(value);
      final jsonMap = jsonDecode(value);
      if (jsonMap['code'] == 200) {
        AppShowToast.showToast(jsonMap['message']);
      } else {
        AppShowToast.showToast(jsonMap['message']);
      }
      notifyListeners();
    }).catchError((onError) {
      AppShowToast.showToast(onError.toString());
      notifyListeners();
    });
  }

  void resetListHistoryPurchase() {
    _listToPay.clear();
    _listToShip.clear();
    _listToRate.clear();
    _listCompleted.clear();
    _listToReceive.clear();
    _listCancel.clear();
    _listReturnRefund.clear();
    _listHistoryPurchase.clear();
    _listOrderIDByProduct.clear();
    _listOrderIDByProductToPay.clear();
    // _isLoading = true;
  }
}