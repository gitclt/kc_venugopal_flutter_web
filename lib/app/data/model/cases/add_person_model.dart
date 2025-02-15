// To parse this JSON data, do
//
//     final addPersonModel = addPersonModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<AddPersonModel> addPersonModelFromJson(String str) =>
    List<AddPersonModel>.from(
        json.decode(str).map((x) => AddPersonModel.fromJson(x)));

String addPersonModelToJson(List<AddPersonModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddPersonModel {
  String? type;
  TextEditingController? name;
  TextEditingController? designation;
  TextEditingController? mobile;
  String? accountId;
  String? caseId;

  AddPersonModel({
    this.type,
    this.name,
    this.designation,
    this.mobile,
    this.accountId,
    this.caseId,
  });

  factory AddPersonModel.fromJson(Map<String, dynamic> json) => AddPersonModel(
        type: json["type"]?.toString(),
        name: json["name"],
        designation: json["designation"],
        mobile: json["mobile"],
        accountId: json["account_id"]?.toString(),
        caseId: json["case_id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "designation": designation,
        "mobile": mobile,
        "account_id": accountId,
        "case_id": caseId,
      };
}
