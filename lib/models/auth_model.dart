class AuthModel {
  int code;
  String message;
  String? token;
  User? user;

  AuthModel({
    required this.code,
    required this.message,
    this.token,
    this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    code: json["code"],
    message: json["message"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  String id;
  String fullName;
  String email;
  String password;
  String token;
  String phone;
  String avatar;
  String status;
  String roleId;
  String rank;
  Role role;
  UpdatedBy? updatedBy;
  String? address;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.token,
    required this.phone,
    required this.avatar,
    required this.status,
    required this.roleId,
    required this.rank,
    required this.role,
    this.updatedBy,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    password: json["password"],
    token: json["token"],
    phone: json["phone"],
    avatar: json["avatar"],
    status: json["status"],
    roleId: json["role_id"],
    rank: json["rank"],
    role: Role.fromJson(json["role"]),
    updatedBy: json['updatedBy'] == null ? null : UpdatedBy.fromJson(json["updatedBy"]),
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "password": password,
    "token": token,
    "phone": phone,
    "avatar": avatar,
    "status": status,
    "role_id": roleId,
    "rank": rank,
    "role": role.toJson(),
    "updatedBy": updatedBy?.toJson(),
    "address": address,
  };
}

class Role {
  String id;
  String title;
  List<String> permissions;

  Role({
    required this.id,
    required this.title,
    required this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["_id"],
    title: json["title"],
    permissions: List<String>.from(json["permissions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "permissions": List<dynamic>.from(permissions.map((x) => x)),
  };
}

class UpdatedBy {
  String accountId;
  String fullName;
  DateTime updatedAt;

  UpdatedBy({
    required this.accountId,
    required this.fullName,
    required this.updatedAt,
  });

  factory UpdatedBy.fromJson(Map<String, dynamic> json) => UpdatedBy(
    accountId: json["account_id"],
    fullName: json["fullName"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "account_id": accountId,
    "fullName": fullName,
    "updatedAt": updatedAt.toIso8601String(),
  };
}