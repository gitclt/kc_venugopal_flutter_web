import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  bool? status;
  String? message;
  Data? data;

  AuthModel({
    this.status,
    this.message,
    this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? encKey;
  int? accountId;

  Data({
    this.encKey,
    this.accountId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        encKey: json["enc_key"],
        accountId: json["account_id"],
      );

  Map<String, dynamic> toJson() => {
        "enc_key": encKey,
        "account_id": accountId,
      };
}

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool? status;
  String? message;
  UserData? data;

  UserResponse({
    this.status,
    this.message,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class UserData {
  String? id;
  String? username;
  String? accountId;
  String? type;
  String? name;
  String? mobile;
  String? account;
  String? email;
  String? description;

  UserData({
    this.id,
    this.username,
    this.accountId,
    this.name,
    this.type,
    this.mobile,
    this.account,
    this.email,
    this.description,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"]?.toString(),
        username: json["username"]?.toString(),
        accountId: json["account_id"]?.toString(),
        name: json["name"]?.toString(),
        type: json["type"],
        mobile: json["mobile"]?.toString(),
        account: json["account"]?.toString(),
        email: json["email"]?.toString(),
        description: json["description"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "account_id": accountId,
        "name": name,
        "type": type,
        "mobile": mobile,
        "account": account,
        "email": email,
        "description": description,
      };
}
