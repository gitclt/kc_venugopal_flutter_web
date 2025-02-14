// To parse this JSON data, do
//
//     final casesViewModel = casesViewModelFromJson(jsonString);

import 'dart:convert';

CasesViewModel casesViewModelFromJson(String str) => CasesViewModel.fromJson(json.decode(str));

String casesViewModelToJson(CasesViewModel data) => json.encode(data.toJson());

class CasesViewModel {
    bool? status;
    String? message;
    String? totalCount;
    String? totalPages;
    List<CasesData>? data;

    CasesViewModel({
        this.status,
        this.message,
        this.totalCount,
        this.totalPages,
        this.data,
    });

    factory CasesViewModel.fromJson(Map<String, dynamic> json) => CasesViewModel(
        status: json["status"],
        message: json["message"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        data: json["data"] == null ? [] : List<CasesData>.from(json["data"]!.map((x) => CasesData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalCount": totalCount,
        "totalPages": totalPages,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CasesData {
    String? id;
    String? type;
    String? name;
    String? address;
    String? email;
    String? mobile;
    String? location;
    String? priorityId;
    String? priority;
    String? assemblyId;
    String? assembly;
    String? categoryId;
    String? category;
    String? date;
    String? time;
    String? title;
    String? comment;
    String? description;
    String? addedby;
    String? accountId;
    String? status;
    String? subject;
    List<ContactPerson>? contactPerson;

    CasesData({
        this.id,
        this.type,
        this.name,
        this.address,
        this.email,
        this.mobile,
        this.location,
        this.priorityId,
        this.priority,
        this.assemblyId,
        this.assembly,
        this.categoryId,
        this.category,
        this.date,
        this.time,
        this.title,
        this.comment,
        this.description,
        this.addedby,
        this.accountId,
        this.status,
        this.subject,
        this.contactPerson,
    });

    factory CasesData.fromJson(Map<String, dynamic> json) => CasesData(
        id: json["id"]?.toString(),
        type: json["type"]?.toString(),
        name: json["name"]?.toString(),
        address: json["address"]?.toString(),
        email: json["email"]?.toString(),
        mobile: json["mobile"]?.toString(),
        location: json["location"]?.toString(),
        priorityId: json["priority_id"]?.toString(),
        priority: json["priority"]?.toString(),
        assemblyId: json["assembly_id"]?.toString(),
        assembly: json["assembly"]?.toString(),
        categoryId: json["category_id"]?.toString(),
        category: json["category"]?.toString(),
        date: json["date"]?.toString(),
        time: json["time"]?.toString(),
        title: json["title"]?.toString(),
        comment: json["comment"]?.toString(),
        description: json["description"]?.toString(),
        addedby: json["addedby"]?.toString(),
        accountId: json["account_id"]?.toString(),
        status: json["status"]?.toString(),
        subject: json["subject"]?.toString(),
        contactPerson: json["contact_person"] == null ? [] : List<ContactPerson>.from(json["contact_person"]!.map((x) => ContactPerson.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "address": address,
        "email": email,
        "mobile": mobile,
        "location": location,
        "priority_id": priorityId,
        "priority": priority,
        "assembly_id": assemblyId,
        "assembly": assembly,
        "category_id": categoryId,
        "category": category,
        "date": date,
        "time": time,
        "title": title,
        "comment": comment,
        "description": description,
        "addedby": addedby,
        "account_id": accountId,
        "status": status,
        "subject": subject,
        "contact_person": contactPerson == null ? [] : List<dynamic>.from(contactPerson!.map((x) => x.toJson())),
    };
}

class ContactPerson {
    String? id;
    String? contactPerson;
    String? mobile;
    String? designation;

    ContactPerson({
        this.id,
        this.contactPerson,
        this.mobile,
        this.designation,
    });

    factory ContactPerson.fromJson(Map<String, dynamic> json) => ContactPerson(
        id: json["id"]?.toString(),
        contactPerson: json["contact_person"]?.toString(),
        mobile: json["mobile"]?.toString(),
        designation: json["designation"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contact_person": contactPerson,
        "mobile": mobile,
        "designation": designation,
    };
}
