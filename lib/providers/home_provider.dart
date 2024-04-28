import 'dart:convert';
import 'package:do_an_mobile/data_sources/repositories/product_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

  List<ProductCategory> _listProductCategory = [];

  List<ProductCategory> get listProductCategory => _listProductCategory;

  productDetailModel.NewProduct? _productDetail;

  productDetailModel.NewProduct? get productDetail => _productDetail;

  List<productDetailModel.Group> _listGroup = [];
  List<productDetailModel.Group> get listGroup => _listGroup;

  Future getAllProductCategory() async {
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
      notifyListeners();
    });
  }

  void resetProductDetail() {
    productDetailModel.NewProduct? newProduct;
    _productDetail = newProduct;
  }

  void setListGroup(List<productDetailModel.Group> list) {
    _listGroup.clear();
    _listGroup.addAll(list);
    notifyListeners();
  }
}
