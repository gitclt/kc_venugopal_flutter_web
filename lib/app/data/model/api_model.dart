// To parse this JSON data, do
//
//     final apiModel = apiModelFromJson(jsonString);

import 'dart:convert';

ApiModel apiModelFromJson(String str) => ApiModel.fromJson(json.decode(str));

String apiModelToJson(ApiModel data) => json.encode(data.toJson());

class ApiModel {
  bool? status;
  String? message;
  String? id;

  ApiModel({
    this.status,
    this.message,
    this.id,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        status: json["status"],
        message: json["message"],
        id: json["id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "id": id,
      };
}
