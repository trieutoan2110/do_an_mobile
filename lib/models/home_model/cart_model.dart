class CartModel {
  Cart cart;

  CartModel({
    required this.cart,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    cart: Cart.fromJson(json["cart"]),
  );

  Map<String, dynamic> toJson() => {
    "cart": cart.toJson(),
  };
}

class Cart {
  String accountId;
  List<Product> products;

  Cart({
    required this.accountId,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    accountId: json["account_id"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  String productId;
  String childTitle;
  int quantity;
  InfoProduct infoProduct;

  Product({
    required this.productId,
    required this.childTitle,
    required this.quantity,
    required this.infoProduct,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["product_id"],
    childTitle: json["childTitle"],
    quantity: json["quantity"],
    infoProduct: InfoProduct.fromJson(json["infoProduct"]),
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "childTitle": childTitle,
    "quantity": quantity,
    "infoProduct": infoProduct.toJson(),
  };
}

class InfoProduct {
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
  String productCategoryTitle;
  ProductChild productChild;

  InfoProduct({
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
    required this.productCategoryTitle,
    required this.productChild,
  });

  factory InfoProduct.fromJson(Map<String, dynamic> json) => InfoProduct(
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