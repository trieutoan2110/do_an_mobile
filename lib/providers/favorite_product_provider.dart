
import 'package:flutter/cupertino.dart';

import '../models/home_model/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<NewProduct> _listProduct = [];
  List<NewProduct> get listProduct => _listProduct;

  void resetListProduct() {
    _listProduct.clear();
  }

  void setListProduct(List<NewProduct> products) {
    _listProduct.addAll(products);
    notifyListeners();
  }

  void deleteProduct(String productID) {
    _listProduct.removeWhere((element) => element.id == productID);
    notifyListeners();
  }
}