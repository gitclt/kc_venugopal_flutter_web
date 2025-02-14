// To parse this JSON data, do
//
//     final addSubAdminAssemblyModel = addSubAdminAssemblyModelFromJson(jsonString);

import 'dart:convert';

List<AddAssembly> addSubAdminAssemblyModelFromJson(String str) =>
    List<AddAssembly>.from(
        json.decode(str).map((x) => AddAssembly.fromJson(x)));

String addSubAdminAssemblyModelToJson(List<AddAssembly> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddAssembly {
  String? assemblyId;
  // String? assembly;

  AddAssembly({
    this.assemblyId,
    //this.assembly,
  });

  factory AddAssembly.fromJson(Map<String, dynamic> json) => AddAssembly(
        assemblyId: json["assembly_id"],
        // assembly: json["assembly"],
      );

  Map<String, dynamic> toJson() => {
        "assembly_id": assemblyId,
        // "assembly": assembly,
      };
}
