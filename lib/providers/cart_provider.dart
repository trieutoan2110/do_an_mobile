import 'dart:convert';

import 'package:do_an_mobile/data_sources/repositories/cart_repository.dart';
import 'package:flutter/material.dart';

import '../models/home_model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _listProductCart= [];
  List<Product> get listProductCart => _listProductCart;
  CartModel? _cartModel;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  double _totalPayment = 0;
  double get totalPayment => _totalPayment;

  Future setAllProductCart() async {
    CartRepositoryImpl.shared.getProductCart().then((value) {
      _cartModel = CartModel.fromJson(jsonDecode(value));
      _listProductCart = _cartModel!.cart.products;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future addProductToCart(String id, String childTitle, int quantity) async {
    print(id);
    print(childTitle);
    print(quantity);
    CartRepositoryImpl.shared.addProductToCart(id, childTitle, quantity).then((value) {
      print(value);
      notifyListeners();
    });
  }

  void resetListProductCart() {
    if (_listProductCart.isNotEmpty) _listProductCart.clear();
    _listProductCart.clear();
  }

  void removeProduct(Product product) {
    _listProductCart.removeWhere((element) => element.productId == product.productId);
    notifyListeners();
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