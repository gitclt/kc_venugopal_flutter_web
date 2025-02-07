// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  bool? status;
  String? message;
  List<CategoryData>? data;

  CategoryModel({
    this.status,
    this.message,
    this.data,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CategoryData>.from(
                json["data"]!.map((x) => CategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CategoryData {
  String? id;
  String? name;
  String? accountId;

  CategoryData({
    this.id,
    this.name,
    this.accountId,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        accountId: json["account_id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "account_id": accountId,
      };
}
