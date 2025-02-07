// To parse this JSON data, do
//
//     final subadminModel = subadminModelFromJson(jsonString);

import 'dart:convert';

SubadminModel subadminModelFromJson(String str) => SubadminModel.fromJson(json.decode(str));

String subadminModelToJson(SubadminModel data) => json.encode(data.toJson());

class SubadminModel {
    bool? status;
    String? message;
    List<SubAdminData>? data;

    SubadminModel({
        this.status,
        this.message,
        this.data,
    });

    factory SubadminModel.fromJson(Map<String, dynamic> json) => SubadminModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<SubAdminData>.from(json["data"]!.map((x) => SubAdminData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class SubAdminData {
    String? id;
    String? name;
    String? accountId;
    String? username;
    String? password;
    String? contactPerson;
    String? mobile;
    List<Assembly>? assemblies;

    SubAdminData({
        this.id,
        this.name,
        this.accountId,
        this.username,
        this.password,
        this.contactPerson,
        this.mobile,
        this.assemblies,
    });

    factory SubAdminData.fromJson(Map<String, dynamic> json) => SubAdminData(
        id: json["id"],
        name: json["name"],
        accountId: json["account_id"]?.toString(),
        username: json["username"],
        password: json["password"],
        contactPerson: json["contact_person"],
        mobile: json["mobile"],
        assemblies: json["assemblies"] == null ? [] : List<Assembly>.from(json["assemblies"]!.map((x) => Assembly.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "account_id": accountId,
        "username": username,
        "password": password,
        "contact_person": contactPerson,
        "mobile": mobile,
        "assemblies": assemblies == null ? [] : List<dynamic>.from(assemblies!.map((x) => x.toJson())),
    };
}

class Assembly {
    String? assemblyId;
    String? assembly;

    Assembly({
        this.assemblyId,
        this.assembly,
    });

    factory Assembly.fromJson(Map<String, dynamic> json) => Assembly(
        assemblyId: json["assembly_id"],
        assembly: json["assembly"],
    );

    Map<String, dynamic> toJson() => {
        "assembly_id": assemblyId,
        "assembly": assembly,
    };
}
