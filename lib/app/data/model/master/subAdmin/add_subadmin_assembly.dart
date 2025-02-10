// To parse this JSON data, do
//
//     final addSubAdminAssemblyModel = addSubAdminAssemblyModelFromJson(jsonString);

import 'dart:convert';

List<AddSubAdminAssemblyModel> addSubAdminAssemblyModelFromJson(String str) => List<AddSubAdminAssemblyModel>.from(json.decode(str).map((x) => AddSubAdminAssemblyModel.fromJson(x)));

String addSubAdminAssemblyModelToJson(List<AddSubAdminAssemblyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddSubAdminAssemblyModel {
    int? subadminId;
    int? accountId;
    int? assemblyId;

    AddSubAdminAssemblyModel({
        this.subadminId,
        this.accountId,
        this.assemblyId,
    });

    factory AddSubAdminAssemblyModel.fromJson(Map<String, dynamic> json) => AddSubAdminAssemblyModel(
        subadminId: json["subadmin_id"],
        accountId: json["account_id"],
        assemblyId: json["assembly_id"],
    );

    Map<String, dynamic> toJson() => {
        "subadmin_id": subadminId,
        "account_id": accountId,
        "assembly_id": assemblyId,
    };
}
