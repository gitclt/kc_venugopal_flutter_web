// To parse this JSON data, do
//
//     final priorityModel = priorityModelFromJson(jsonString);

import 'dart:convert';

PriorityModel priorityModelFromJson(String str) => PriorityModel.fromJson(json.decode(str));

String priorityModelToJson(PriorityModel data) => json.encode(data.toJson());

class PriorityModel {
    bool? status;
    String? message;
    List<PriorityData>? data;

    PriorityModel({
        this.status,
        this.message,
        this.data,
    });

    factory PriorityModel.fromJson(Map<String, dynamic> json) => PriorityModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<PriorityData>.from(json["data"]!.map((x) => PriorityData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class PriorityData {
    String? id;
    String? name;
    String? accountId;

    PriorityData({
        this.id,
        this.name,
        this.accountId,
    });

    factory PriorityData.fromJson(Map<String, dynamic> json) => PriorityData(
        id: json["id"],
        name: json["name"],
        accountId: json["account_id"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "account_id": accountId,
    };
}
