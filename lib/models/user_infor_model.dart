class UserInfor {
  String token;
  String email;
  String username;
  String avatar;
  String phone;
  String address;
  String ranking;

  UserInfor({
    required this.token,
    required this.email,
    required this.username,
    required this.avatar,
    required this.phone,
    required this.address,
    required this.ranking
  });
}

class EditProfileModel {
  int code;
  String message;
  User user;

  EditProfileModel({
    required this.code,
    required this.message,
    required this.user,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
    code: json["code"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "user": user.toJson(),
  };
}

class User {
  String id;
  String fullName;
  String email;
  String password;
  String token;
  String roleId;
  String status;
  int rank;
  bool deleted;
  DateTime createdAt;
  DateTime updatedAt;
  String avatar;
  String phone;
  String address;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.token,
    required this.roleId,
    required this.status,
    required this.rank,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.phone,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
    token: json["token"],
    roleId: json["role_id"],
    status: json["status"],
    rank: json["rank"],
    deleted: json["deleted"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    avatar: json["avatar"],
    phone: json["phone"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "password": password,
    "token": token,
    "role_id": roleId,
    "status": status,
    "rank": rank,
    "deleted": deleted,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "avatar": avatar,
    "phone": phone,
    "address": address,
  };
}
