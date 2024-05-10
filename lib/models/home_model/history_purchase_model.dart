class HistoryPurchaseModel {
  List<HistoryPurchase> historyPurchase;

  HistoryPurchaseModel({
    required this.historyPurchase,
  });

  factory HistoryPurchaseModel.fromJson(Map<String, dynamic> json) => HistoryPurchaseModel(
    historyPurchase: List<HistoryPurchase>.from(json["historyPurchase"].map((x) => HistoryPurchase.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "historyPurchase": List<dynamic>.from(historyPurchase.map((x) => x.toJson())),
  };
}

class HistoryPurchase {
  String id;
  String cartId;
  UserInfo userInfo;
  List<Product> products;
  String discountId;
  int statusOrder;
  bool deleted;
  DateTime updateTime;
  DateTime createdAt;

  HistoryPurchase({
    required this.id,
    required this.cartId,
    required this.userInfo,
    required this.products,
    required this.discountId,
    required this.statusOrder,
    required this.deleted,
    required this.updateTime,
    required this.createdAt,
  });

  factory HistoryPurchase.fromJson(Map<String, dynamic> json) => HistoryPurchase(
    id: json["id"],
    cartId: json["cart_id"],
    userInfo: UserInfo.fromJson(json["userInfo"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    discountId: json["discountId"],
    statusOrder: json["statusOrder"],
    deleted: json["deleted"],
    updateTime: DateTime.parse(json["updateTime"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cart_id": cartId,
    "userInfo": userInfo.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "discountId": discountId,
    "statusOrder": statusOrder,
    "deleted": deleted,
    "updateTime": updateTime.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class Product {
  String productId;
  String childTitle;
  int statusComment;
  int quantity;
  int totalPrice;
  InforProduct inforProduct;

  Product({
    required this.productId,
    required this.childTitle,
    required this.statusComment,
    required this.quantity,
    required this.totalPrice,
    required this.inforProduct,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    childTitle: json["childTitle"],
    statusComment: json['statusComment'],
    quantity: json["quantity"],
    totalPrice: json["totalPrice"],
    inforProduct: InforProduct.fromJson(json["inforProduct"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "childTitle": childTitle,
    'statusComment': statusComment,
    "quantity": quantity,
    "totalPrice": totalPrice,
    "inforProduct": inforProduct.toJson(),
  };
}

class InforProduct {
  String title;
  String description;
  List<String> images;
  String featured;
  String status;
  List<Property> properties;
  bool deleted;
  String slug;
  double rate;
  int discountPercent;
  String productCategoryId;
  String productCategoryTitle;
  ProductChild productChild;

  InforProduct({
    required this.title,
    required this.description,
    required this.images,
    required this.featured,
    required this.status,
    required this.properties,
    required this.deleted,
    required this.slug,
    required this.rate,
    required this.discountPercent,
    required this.productCategoryId,
    required this.productCategoryTitle,
    required this.productChild,
  });

  factory InforProduct.fromJson(Map<String, dynamic> json) => InforProduct(
    title: json["title"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    featured: json["featured"],
    status: json["status"],
    properties: List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
    deleted: json["deleted"],
    slug: json["slug"],
    rate: json["rate"]?.toDouble(),
    discountPercent: json["discountPercent"],
    productCategoryId: json["productCategoryId"],
    productCategoryTitle: json["productCategoryTitle"],
    productChild: ProductChild.fromJson(json["productChild"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "featured": featured,
    "status": status,
    "properties": List<dynamic>.from(properties.map((x) => x.toJson())),
    "deleted": deleted,
    "slug": slug,
    "rate": rate,
    "discountPercent": discountPercent,
    "productCategoryId": productCategoryId,
    "productCategoryTitle": productCategoryTitle,
    "productChild": productChild.toJson(),
  };
}

class ProductChild {
  String childTitle;
  int price;
  int quantity;
  int stock;
  int priceNew;

  ProductChild({
    required this.childTitle,
    required this.price,
    required this.quantity,
    required this.stock,
    required this.priceNew,
  });

  factory ProductChild.fromJson(Map<String, dynamic> json) => ProductChild(
    childTitle: json["childTitle"],
    price: json["price"],
    quantity: json["quantity"],
    stock: json["stock"],
    priceNew: json["priceNew"],
  );

  Map<String, dynamic> toJson() => {
    "childTitle": childTitle,
    "price": price,
    "quantity": quantity,
    "stock": stock,
    "priceNew": priceNew,
  };
}

class Property {
  String? size;
  String? color;

  Property({
    this.size,
    this.color,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    size: json["Size"],
    color: json["Color"],
  );

  Map<String, dynamic> toJson() => {
    "Size": size,
    "Color": color,
  };
}

class UserInfo {
  String fullName;
  String phone;
  String address;

  UserInfo({
    required this.fullName,
    required this.phone,
    required this.address,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    fullName: json["fullName"],
    phone: json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phone": phone,
    "address": address,
  };
}

class FeedbackModel {
  int code;
  String message;
  String? avatar;

  FeedbackModel({
    required this.code,
    required this.message,
    this.avatar
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) => FeedbackModel(
      code: json['code'], message: json['message'], avatar: json['avatar']);
}