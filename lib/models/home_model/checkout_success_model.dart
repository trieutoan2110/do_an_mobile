class CheckOutSuccessModel {
  int code;
  String message;
  Data data;

  CheckOutSuccessModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory CheckOutSuccessModel.fromJson(Map<String, dynamic> json) => CheckOutSuccessModel(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String cartId;
  UserInfo userInfo;
  List<Product> products;
  String discountId;
  int statusOrder;
  bool deleted;
  DateTime updateTime;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.cartId,
    required this.userInfo,
    required this.products,
    required this.discountId,
    required this.statusOrder,
    required this.deleted,
    required this.updateTime,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cartId: json["cart_id"],
    userInfo: UserInfo.fromJson(json["userInfo"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    discountId: json["discountId"],
    statusOrder: json["statusOrder"],
    deleted: json["deleted"],
    updateTime: DateTime.parse(json["updateTime"]),
    id: json["_id"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId,
    "userInfo": userInfo.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "discountId": discountId,
    "statusOrder": statusOrder,
    "deleted": deleted,
    "updateTime": updateTime.toIso8601String(),
    "_id": id,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Product {
  String productId;
  String childTitle;
  int quantity;
  int statusComment;
  String id;

  Product({
    required this.productId,
    required this.childTitle,
    required this.quantity,
    required this.statusComment,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    childTitle: json["childTitle"],
    quantity: json["quantity"],
    statusComment: json["statusComment"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "childTitle": childTitle,
    "quantity": quantity,
    "statusComment": statusComment,
    "_id": id,
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