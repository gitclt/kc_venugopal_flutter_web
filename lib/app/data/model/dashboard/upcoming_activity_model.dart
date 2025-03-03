// To parse this JSON data, do
//
//     final upcomingActivityModel = upcomingActivityModelFromJson(jsonString);

import 'dart:convert';

UpcomingActivityModel upcomingActivityModelFromJson(String str) => UpcomingActivityModel.fromJson(json.decode(str));

String upcomingActivityModelToJson(UpcomingActivityModel data) => json.encode(data.toJson());

class UpcomingActivityModel {
    bool? status;
    List<Reminder>? reminders;

    UpcomingActivityModel({
        this.status,
        this.reminders,
    });

    factory UpcomingActivityModel.fromJson(Map<String, dynamic> json) => UpcomingActivityModel(
        status: json["status"],
        reminders: json["reminders"] == null ? [] : List<Reminder>.from(json["reminders"]!.map((x) => Reminder.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "reminders": reminders == null ? [] : List<dynamic>.from(reminders!.map((x) => x.toJson())),
    };
}

class Reminder {
    String? label;
    String? value;
    String? count;

    Reminder({
        this.label,
        this.value,
        this.count,
    });

    factory Reminder.fromJson(Map<String, dynamic> json) => Reminder(
        label: json["label"],
        value: json["value"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
        "count": count,
    };
}
