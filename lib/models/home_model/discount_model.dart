class DiscountModel {
  List<Discount> listDiscount;

  DiscountModel({
    required this.listDiscount,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
    listDiscount: List<Discount>.from(json["listDiscount"].map((x) => Discount.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "listDiscount": List<dynamic>.from(listDiscount.map((x) => x.toJson())),
  };
}

class Discount {
  CreatedBy createdBy;
  String id;
  String title;
  String description;
  int discountPercent;
  int conditionRank;
  String specialDay;
  bool deleted;

  Discount({
    required this.createdBy,
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercent,
    required this.conditionRank,
    required this.specialDay,
    required this.deleted,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    createdBy: CreatedBy.fromJson(json["createdBy"]),
    id: json["_id"],
    title: json["title"],
    description: json["description"],
    discountPercent: json["discountPercent"],
    conditionRank: json["conditionRank"],
    specialDay: json["specialDay"],
    deleted: json["deleted"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy.toJson(),
    "_id": id,
    "title": title,
    "description": description,
    "discountPercent": discountPercent,
    "conditionRank": conditionRank,
    "specialDay": specialDay,
    "deleted": deleted,
  };
}

class CreatedBy {
  DateTime createdAt;

  CreatedBy({
    required this.createdAt,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
  };
}
