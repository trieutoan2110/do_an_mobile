import 'dart:convert';

import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/repositories/cart_repository.dart';
import 'package:do_an_mobile/models/home_model/history_purchase_model.dart' as HisroryPurchase;
import 'package:flutter/material.dart';

import '../data_sources/repositories/favorite_product_repository.dart';
import '../models/home_model/cart_model.dart';
import '../models/home_model/history_purchase_model.dart' as historyPurchase;

class CartProvider extends ChangeNotifier {
  List<Product> _listProductCart= [];
  List<Product> get listProductCart => _listProductCart;
  CartModel? _cartModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  double _totalPayment = 0;
  double get totalPayment => _totalPayment;

  Future setAllProductCart() async {
    _isLoading = true;
    CartRepositoryImpl.shared.getProductCart().then((value) {
      _cartModel = CartModel.fromJson(jsonDecode(value));
      _listProductCart = _cartModel!.cart.products;
      _isLoading = false;
      notifyListeners();
    })
    .catchError((onError) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future addProductToCart(String id, String childTitle, int quantity) async {
    CartRepositoryImpl.shared.addProductToCart(id, childTitle, quantity).then((value) {
      AppShowToast.showToast('add to cart success');
      notifyListeners();
    });
  }

  Future deleteProductFromCart(String id, String childTitle) async {
    _listProductCart.removeWhere((element) => element.productId == id && element.childTitle == childTitle);
    CartRepositoryImpl.shared
        .deleteProductFrmCart(id, childTitle).then((value) {
          HisroryPurchase.FeedbackModel model = HisroryPurchase.FeedbackModel.fromJson(jsonDecode(value));
          if (model.code == 200) {
            AppShowToast.showToast(model.message);
          } else {
            AppShowToast.showToast(model.message);
          }
    }).catchError((onError) {
      AppShowToast.showToast(onError);
    });
    notifyListeners();
  }


  void resetListProductCart() {
    if (_listProductCart.isNotEmpty) _listProductCart.clear();
    _listProductCart.clear();
  }

  bool _isSelected = false;
  bool get isSelected => _isSelected;

  void setIsSelected(value) {
    _isSelected = value;
    notifyListeners();
  }

  void setTotalPayment(int value, bool isSelected) {
    if (isSelected) {
      _totalPayment += value;
    } else {
      _totalPayment -= value;
    }
    notifyListeners();
  }

  void resetTotalPayment() {
    _totalPayment = 0;
  }
}