// To parse this JSON data, do
//
//     final assemblyModel = assemblyModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

AssemblyModel assemblyModelFromJson(String str) =>
    AssemblyModel.fromJson(json.decode(str));

String assemblyModelToJson(AssemblyModel data) => json.encode(data.toJson());

class AssemblyModel {
  bool? status;
  String? message;
  List<AssemblyData>? data;

  AssemblyModel({
    this.status,
    this.message,
    this.data,
  });

  factory AssemblyModel.fromJson(Map<String, dynamic> json) => AssemblyModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<AssemblyData>.from(
                json["data"]!.map((x) => AssemblyData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class AssemblyData {
  String? id;
  String? name;
  String? accountId;
  RxBool? isSelect;

  AssemblyData({this.id, this.name, this.accountId, this.isSelect});

  factory AssemblyData.fromJson(Map<String, dynamic> json) => AssemblyData(
      id: json["id"],
      name: json["name"],
      accountId: json["account_id"]?.toString(),
      isSelect: false.obs);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "account_id": accountId,
      };
}
