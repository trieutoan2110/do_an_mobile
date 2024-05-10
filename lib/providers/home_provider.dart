import 'dart:convert';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/repositories/product_repository.dart';
import 'package:do_an_mobile/models/home_model/category_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../data_sources/repositories/favorite_product_repository.dart';
import '../models/home_model/history_purchase_model.dart' as historyPurchase;
import '../models/home_model/product_category_model.dart';
import '../models/home_model/product_model.dart';
import '../models/home_model/product_detail_model.dart' as productDetailModel;

class HomeProvider extends ChangeNotifier {
  List<NewProduct> _listProductBestSeller = [];

  List<NewProduct> get listProductBestSeller => _listProductBestSeller;

  List<NewProduct> _listProductBestRate = [];

  List<NewProduct> get listProductBestRate => _listProductBestRate;

  List<NewProduct> _listProductFeatured = [];

  List<NewProduct> get listProductFeatured => _listProductFeatured;

  List<NewProduct> _listProductInCategory = [];
  List<NewProduct> get listProductInCategory => _listProductInCategory;

  List<ProductCategory> _listProductCategory = [];

  List<ProductCategory> get listProductCategory => _listProductCategory;

  productDetailModel.NewProductDetail? _productDetail;

  productDetailModel.NewProductDetail? get productDetail => _productDetail;

  List<productDetailModel.NewFeedback> _listFeedback = [];
  List<productDetailModel.NewFeedback> get listFeedback => _listFeedback;

  List<productDetailModel.Group> _listGroup = [];
  List<productDetailModel.Group> get listGroup => _listGroup;

  Future getAllCategory() async {
    ProductRepositoryImpl.shared.getProductCategory().then((value) {
      ProductCategoryModel productCategoryModel =
          ProductCategoryModel.fromJson(jsonDecode(value));
      _listProductCategory = productCategoryModel.productCategorys;
      notifyListeners();
    });
  }

  Future getAllProductBestSeller() async {
    ProductRepositoryImpl.shared.getProductBestSeller().then((value) {
      ProductModel productModel = ProductModel.fromJson(jsonDecode(value));
      _listProductBestSeller = productModel.newProduct;
      notifyListeners();
    });
  }

  Future getAllProductBestRate() async {
    ProductRepositoryImpl.shared.getProductBestRate().then((value) {
      ProductModel productModel = ProductModel.fromJson(jsonDecode(value));
      _listProductBestRate = productModel.newProduct;
      notifyListeners();
    });
  }

  Future getAllProductFeatured() async {
    ProductRepositoryImpl.shared.getProductFeatured().then((value) {
      ProductModel productModel = ProductModel.fromJson(jsonDecode(value));
      _listProductFeatured = productModel.newProduct;
      notifyListeners();
    });
  }

  Future getProductDetail(String productID) async {
    ProductRepositoryImpl.shared.getProductDetail(productID).then((value) {
      final productDetail =
          productDetailModel.ProductDetailModel.fromJson(jsonDecode(value));
      _productDetail = productDetail.newProduct;
      _listFeedback = productDetail.newFeedbacks;
      notifyListeners();
    });
  }
  
  Future getProductFromCategory(String categoryParent) async {
    ProductRepositoryImpl.shared.getProductFormCategory(categoryParent).then((value) {
      CategoryModel categoryModel = CategoryModel.fromJson(jsonDecode(value));
      _listProductInCategory = categoryModel.products;
      notifyListeners();
    }).catchError((onError) {
      AppShowToast.showToast(onError.toString());
    });
  }

  void resetListProductInCart() {
    _listProductInCategory.clear();
  }

  void resetProductDetail() {
    productDetailModel.NewProductDetail? newProduct;
    _productDetail = newProduct;
  }

  void setListGroup(List<productDetailModel.Group> list) {
    _listGroup.clear();
    _listGroup.addAll(list);
    notifyListeners();
  }

  Future addProductToWishList(String productID) async {
    FavoriteRepositoryImpl.shared
        .addProductInListFavorite(productID).then((value) {
      historyPurchase.FeedbackModel model = historyPurchase.FeedbackModel.fromJson(jsonDecode(value));
      AppShowToast.showToast(model.message);
      print(model.message);
    }).catchError((onError) {
      AppShowToast.showToast(onError.toString());
      print(onError);
    });
  }
}
