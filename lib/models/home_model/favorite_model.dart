import 'package:do_an_mobile/models/home_model/product_model.dart';

class FavoriteModel {
  int code;
  List<NewProduct> products;

  FavoriteModel({
    required this.code,
    required this.products,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
    code: json["code"],
    products: List<NewProduct>.from(json["listProductsFavorite"].map((x) => NewProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "listProductsFavorite": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}