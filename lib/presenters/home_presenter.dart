import 'dart:convert';

import '../data_sources/repositories/product_repository.dart';
import '../models/home_model/category_model.dart';
import '../models/home_model/product_model.dart';

abstract class HomeViewContract {
  void getProductInCategoryComplete(List<NewProduct> list);
  void getProductInCategoryError(String msg);
}

class HomePresenter {
  final HomeViewContract? _view;
  HomePresenter(this._view);

  Future getProductFromCategory(String categoryParent) async {
    ProductRepositoryImpl.shared.getProductFormCategory(categoryParent).then((value) {
      CategoryModel categoryModel = CategoryModel.fromJson(jsonDecode(value));
      _view!.getProductInCategoryComplete(categoryModel.products);
    }).catchError((onError) {
      _view!.getProductInCategoryError(onError.toString());
    });
  }
}