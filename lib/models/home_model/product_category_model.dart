class ProductCategoryModel {
  int code;
  List<ProductCategory> productCategorys;

  ProductCategoryModel({
    required this.code,
    required this.productCategorys,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) => ProductCategoryModel(
    code: json["code"],
    productCategorys: List<ProductCategory>.from(json["productCategorys"].map((x) => ProductCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "productCategorys": List<dynamic>.from(productCategorys.map((x) => x.toJson())),
  };
}

class ProductCategory {
  CreatedBy createdBy;
  UpdatedBy? updatedBy;
  String id;
  String title;
  String parentId;
  String description;
  String image;
  String status;
  List<String> properties;
  bool deleted;
  String slug;
  int v;

  ProductCategory({
    required this.createdBy,
    this.updatedBy,
    required this.id,
    required this.title,
    required this.parentId,
    required this.description,
    required this.image,
    required this.status,
    required this.properties,
    required this.deleted,
    required this.slug,
    required this.v,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => ProductCategory(
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    updatedBy: json["updatedBy"] == null ? null : UpdatedBy.fromJson(json["updatedBy"]),
    id: json["_id"],
    title: json["title"],
    parentId: json["parentId"],
    description: json["description"],
    image: json["image"],
    status: json["status"],
    properties: List<String>.from(json["properties"].map((x) => x)),
    deleted: json["deleted"],
    slug: json["slug"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy.toJson(),
    "updatedBy": updatedBy?.toJson(),
    "_id": id,
    "title": title,
    "parentId": parentId,
    "description": description,
    "image": image,
    "status": status,
    "properties": List<dynamic>.from(properties.map((x) => x)),
    "deleted": deleted,
    "slug": slug,
    "__v": v,
  };
}

class CreatedBy {
  String accountId;
  DateTime createdAt;

  CreatedBy({
    required this.accountId,
    required this.createdAt,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    accountId: json["account_id"]!,
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "createdAt": createdAt.toIso8601String(),
  };
}

class UpdatedBy {
  String accountId;
  DateTime updatedAt;

  UpdatedBy({
    required this.accountId,
    required this.updatedAt,
  });

  factory UpdatedBy.fromJson(Map<String, dynamic> json) => UpdatedBy(
    accountId: json["account_id"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "updatedAt": updatedAt.toIso8601String(),
  };
}