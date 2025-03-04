// To parse this JSON data, do
//
//     final todaysActivityModel = todaysActivityModelFromJson(jsonString);

import 'dart:convert';

TodaysActivityModel todaysActivityModelFromJson(String str) =>
    TodaysActivityModel.fromJson(json.decode(str));

String todaysActivityModelToJson(TodaysActivityModel data) =>
    json.encode(data.toJson());

class TodaysActivityModel {
  bool? status;
  List<TodaysData>? data;

  TodaysActivityModel({
    this.status,
    this.data,
  });

  factory TodaysActivityModel.fromJson(Map<String, dynamic> json) =>
      TodaysActivityModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<TodaysData>.from(
                json["data"]!.map((x) => TodaysData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TodaysData {
  String? type;
  String? count;
  String? reminderCount;

  TodaysData({
    this.type,
    this.count,
    this.reminderCount,
  });

  factory TodaysData.fromJson(Map<String, dynamic> json) => TodaysData(
        type: json["type"]?.toString(),
        count: json["count"]?.toString(),
        reminderCount: json["reminderCount"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "count": count,
        "reminderCount": reminderCount,
      };
}
