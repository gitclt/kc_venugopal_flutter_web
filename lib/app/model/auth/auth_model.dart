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



UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

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
    int? id;
    String? username;
    int? accountId;
    dynamic name;
    dynamic mobile;
    String? account;
    String? email;
    String? description;

    UserData({
        this.id,
        this.username,
        this.accountId,
        this.name,
        this.mobile,
        this.account,
        this.email,
        this.description,
    });

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        username: json["username"],
        accountId: json["account_id"],
        name: json["name"],
        mobile: json["mobile"],
        account: json["account"],
        email: json["email"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "account_id": accountId,
        "name": name,
        "mobile": mobile,
        "account": account,
        "email": email,
        "description": description,
    };
}
