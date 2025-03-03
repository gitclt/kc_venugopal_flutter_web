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
  Data? data;

  TodaysActivityModel({
    this.status,
    this.data,
  });

  factory TodaysActivityModel.fromJson(Map<String, dynamic> json) =>
      TodaysActivityModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  String? birthday;
  String? programschedule;
  String? supportrequest;
  String? wedding;
  String? birthdayReminders;
  String? programscheduleReminders;
  String? supportrequestReminders;
  String? weddingReminders;

  Data({
    this.birthday,
    this.programschedule,
    this.supportrequest,
    this.wedding,
    this.birthdayReminders,
    this.programscheduleReminders,
    this.supportrequestReminders,
    this.weddingReminders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        birthday: json["birthday"]?.toString(),
        programschedule: json["programschedule"]?.toString(),
        supportrequest: json["supportrequest"]?.toString(),
        wedding: json["wedding"]?.toString(),
        birthdayReminders: json["birthdayReminders"]?.toString(),
        programscheduleReminders: json["programscheduleReminders"]?.toString(),
        supportrequestReminders: json["supportrequestReminders"]?.toString(),
        weddingReminders: json["weddingReminders"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "programschedule": programschedule,
        "supportrequest": supportrequest,
        "wedding": wedding,
        "birthdayReminders": birthdayReminders,
        "programscheduleReminders": programscheduleReminders,
        "supportrequestReminders": supportrequestReminders,
        "weddingReminders": weddingReminders,
      };
}
