class ProductDetailModel {
  int code;
  NewProductDetail newProduct;
  List<NewFeedback> newFeedbacks;

  ProductDetailModel({
    required this.code,
    required this.newProduct,
    required this.newFeedbacks,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
    code: json["code"],
    newProduct: NewProductDetail.fromJson(json["newProduct"]),
    newFeedbacks: List<NewFeedback>.from(json["newFeedbacks"].map((x) => NewFeedback.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "newProduct": newProduct.toJson(),
    "newFeedbacks": List<dynamic>.from(newFeedbacks.map((x) => x.toJson())),
  };
}

class NewFeedback {
  String productId;
  String orderId;
  String? comment;
  int rate;
  bool deleted;
  String fullName;

  NewFeedback({
    required this.productId,
    required this.orderId,
    this.comment,
    required this.rate,
    required this.deleted,
    required this.fullName,
  });

  factory NewFeedback.fromJson(Map<String, dynamic> json) => NewFeedback(
    productId: json["productId"],
    orderId: json["orderId"],
    comment: json["comment"] == null ? '' : json['comment'],
    rate: json["rate"],
    deleted: json["deleted"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "orderId": orderId,
    "comment": comment,
    "rate": rate,
    "deleted": deleted,
    "fullName": fullName,
  };
}

class NewProductDetail {
  String id;
  String title;
  String description;
  List<String> images;
  List<Group> group;
  String featured;
  String status;
  List<Property> properties;
  bool deleted;
  String slug;
  double rate;
  String productCategoryId;
  int discountPercent;
  List<Group> newGroup;
  int minPrice;
  int buyed;
  String productCategoryTitle;

  NewProductDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.group,
    required this.featured,
    required this.status,
    required this.properties,
    required this.deleted,
    required this.slug,
    required this.rate,
    required this.productCategoryId,
    required this.discountPercent,
    required this.newGroup,
    required this.minPrice,
    required this.buyed,
    required this.productCategoryTitle,
  });

  factory NewProductDetail.fromJson(Map<String, dynamic> json) => NewProductDetail(
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    group: List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
    featured: json["featured"],
    status: json["status"],
    properties: List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
    deleted: json["deleted"],
    slug: json["slug"],
    rate: json["rate"]?.toDouble(),
    productCategoryId: json["productCategoryId"],
    discountPercent: json["discountPercent"],
    newGroup: List<Group>.from(json["newGroup"].map((x) => Group.fromJson(x))),
    minPrice: json["minPrice"],
    buyed: json["buyed"],
    productCategoryTitle: json["productCategoryTitle"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "group": List<dynamic>.from(group.map((x) => x.toJson())),
    "featured": featured,
    "status": status,
    "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
    "deleted": deleted,
    "slug": slug,
    "rate": rate,
    "productCategoryId": productCategoryId,
    "discountPercent": discountPercent,
    "newGroup": List<dynamic>.from(newGroup.map((x) => x.toJson())),
    "minPrice": minPrice,
    "buyed": buyed,
    "productCategoryTitle": productCategoryTitle,
  };
}

class Group {
  String childTitle;
  int price;
  int stock;
  int quantity;
  String? id;
  int? priceNew;

  Group({
    required this.childTitle,
    required this.price,
    required this.stock,
    required this.quantity,
    this.id,
    this.priceNew,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
    childTitle: json["childTitle"],
    price: json["price"],
    stock: json["stock"],
    quantity: json["quantity"],
    id: json["_id"],
    priceNew: json["priceNew"],
  );

  Map<String, dynamic> toJson() => {
    "childTitle": childTitle,
    "price": price,
    "stock": stock,
    "quantity": quantity,
    "_id": id,
    "priceNew": priceNew,
  };
}

class Property {
  String key;
  String value;

  Property({
    required this.key,
    required this.value,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
      key: json.keys.first,
      value: json.values.first
  );

  Map<String, dynamic> toJson() => {
    key : value
  };
}