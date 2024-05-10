import 'package:do_an_mobile/models/home_model/product_model.dart';

class CategoryModel {
  int countRecord;
  List<NewProduct> products;

  CategoryModel({
    required this.countRecord,
    required this.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    countRecord: json["countRecord"],
    products: List<NewProduct>.from(json["products"].map((x) => NewProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "countRecord": countRecord,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}