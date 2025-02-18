// To parse this JSON data, do
//
//     final casesDetailModel = casesDetailModelFromJson(jsonString);

import 'dart:convert';

CasesDetailModel casesDetailModelFromJson(String str) =>
    CasesDetailModel.fromJson(json.decode(str));

String casesDetailModelToJson(CasesDetailModel data) =>
    json.encode(data.toJson());

class CasesDetailModel {
  bool? status;
  String? message;
  List<CaseDetailData>? data;

  CasesDetailModel({
    this.status,
    this.message,
    this.data,
  });

  factory CasesDetailModel.fromJson(Map<String, dynamic> json) =>
      CasesDetailModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<CaseDetailData>.from(
                json["data"]!.map((x) => CaseDetailData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CaseDetailData {
  String? id;
  dynamic name;
  dynamic address;
  dynamic email;
  dynamic mobile;
  String? location;
  String? categoryId;
  String? category;
  String? priorityId;
  String? assemblyId;
  String? assembly;
  String? priority;
  String? time;
  String? date;
  String? title;
  String? description;
  String? type;
  dynamic comment;
  dynamic subject;
  String? status;
  List<CaseDocument>? caseDocuments;
  List<CaseStatus>? caseStatus;
  List<ContactPersonDetail>? contactPerson;

  CaseDetailData({
    this.id,
    this.name,
    this.address,
    this.email,
    this.mobile,
    this.location,
    this.categoryId,
    this.category,
    this.priorityId,
    this.assemblyId,
    this.assembly,
    this.priority,
    this.time,
    this.date,
    this.title,
    this.description,
    this.type,
    this.comment,
    this.subject,
    this.status,
    this.caseDocuments,
    this.caseStatus,
    this.contactPerson,
  });

  factory CaseDetailData.fromJson(Map<String, dynamic> json) => CaseDetailData(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        address: json["address"]?.toString(),
        email: json["email"]?.toString(),
        mobile: json["mobile"]?.toString(),
        location: json["location"]?.toString(),
        categoryId: json["category_id"]?.toString(),
        category: json["category"]?.toString(),
        priorityId: json["priority_id"]?.toString(),
        assemblyId: json["assembly_id"]?.toString(),
        assembly: json["assembly"]?.toString(),
        priority: json["priority"]?.toString(),
        time: json["time"]?.toString(),
        date: json["date"]?.toString(),
        title: json["title"]?.toString(),
        description: json["description"]?.toString(),
        type: json["type"]?.toString(),
        comment: json["comment"]?.toString(),
        subject: json["subject"]?.toString(),
        status: json["status"]?.toString(),
        caseDocuments: json["case_documents"] == null
            ? []
            : List<CaseDocument>.from(
                json["case_documents"]!.map((x) => CaseDocument.fromJson(x))),
        caseStatus: json["case_status"] == null
            ? []
            : List<CaseStatus>.from(
                json["case_status"]!.map((x) => CaseStatus.fromJson(x))),
        contactPerson: json["contact_person"] == null
            ? []
            : List<ContactPersonDetail>.from(
                json["contact_person"]!.map((x) => ContactPersonDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "email": email,
        "mobile": mobile,
        "location": location,
        "category_id": categoryId,
        "category": category,
        "priority_id": priorityId,
        "assembly_id": assemblyId,
        "assembly": assembly,
        "priority": priority,
        "time": time,
        "date": date,
        "title": title,
        "description": description,
        "type": type,
        "comment": comment,
        "subject": subject,
        "status": status,
        "case_documents": caseDocuments == null
            ? []
            : List<dynamic>.from(caseDocuments!.map((x) => x.toJson())),
        "case_status": caseStatus == null
            ? []
            : List<dynamic>.from(caseStatus!.map((x) => x.toJson())),
        "contact_person": contactPerson == null
            ? []
            : List<dynamic>.from(contactPerson!.map((x) => x.toJson())),
      };
}

class CaseDocument {
  String? id;
  String? documentPath;

  CaseDocument({
    this.id,
    this.documentPath,
  });

  factory CaseDocument.fromJson(Map<String, dynamic> json) => CaseDocument(
        id: json["id"]?.toString(),
        documentPath: json["document_path"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "document_path": documentPath,
      };
}

class CaseStatus {
  String? id;
  String? remark;
  String? status;
  String? date;
  String? caseId;
  String? name;

  CaseStatus({
    this.id,
    this.remark,
    this.status,
    this.date,
    this.caseId,
    this.name,
  });

  factory CaseStatus.fromJson(Map<String, dynamic> json) => CaseStatus(
        id: json["id"]?.toString(),
        remark: json["remark"]?.toString(),
        status: json["status"]?.toString(),
        date: json["date"]?.toString(),
        caseId: json["case_id"]?.toString(),
        name: json["name"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "remark": remark,
        "status": status,
        "date": date,
        "case_id": caseId,
        "name": name,
      };
}

class ContactPersonDetail {
  String? id;
  String? contactPerson;
  String? mobile;

  ContactPersonDetail({
    this.id,
    this.contactPerson,
    this.mobile,
  });

  factory ContactPersonDetail.fromJson(Map<String, dynamic> json) => ContactPersonDetail(
        id: json["id"]?.toString(),
        contactPerson: json["contact_person"]?.toString(),
        mobile: json["mobile"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contact_person": contactPerson,
        "mobile": mobile,
      };
}
