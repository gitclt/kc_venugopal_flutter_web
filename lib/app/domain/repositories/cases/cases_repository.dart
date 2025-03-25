import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/cases/cases_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/api_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/add_person_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_detail_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';

class CasesRepository {
  final _apiServices = NetworkApiServices();

  Future<Either<Failure, CasesViewModel>> getCasesList(
      {String? accountId,
      String? page,
      String? pageSize,
      String? type,
      String? fromDate,
      String? toDate,
      String? status,
      String? categoryId,
      String? priorityId,
      String? timeRange,
      String? month,
      String? date,
      String? assemblyId,
      String? keyword}) async {
    try {
      var body = {
        "account_id": accountId,
        if (page != null) "page": page,
        if (pageSize != null) "pageSize": pageSize,
        if (type != null) "type": type,
        if (fromDate != null) "fromdate": fromDate,
        "todate": toDate ?? '',
        "status": status ?? '',
        "category_id": categoryId ?? '',
        "priority_id": priorityId ?? '',
        "timeRange": timeRange ?? '',
        "month": month ?? '',
        if (date != null) "date": date,
        if (keyword != null) "keyword": keyword,
        if (assemblyId != null) "assembly_id": assemblyId
      };
      dynamic response = await _apiServices.postApi(body, CasesUrl.viewCases);

      if (response != null && response["status"] == true) {
        CasesViewModel res = CasesViewModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ApiModel>> addCases(
      {String? type,
      String? assemblyId,
      String? priorityId,
      String? categoryId,
      String? date,
      String? time,
      String? location,
      String? title,
      String? comment,
      String? subject,
      String? name,
      String? address,
      String? email,
      String? mobile,
      String? description,
      String? reminderDate,
      String? addedBy,
      String? addedType,
      String? accountId}) async {
    try {
      var data = json.encode({
        "type": type,
        if (assemblyId != null && assemblyId.isNotEmpty)
          "assembly_id": assemblyId,
        if (priorityId != null && priorityId.isNotEmpty)
          "priority_id": priorityId,
        if (categoryId != null && categoryId.isNotEmpty)
          "category_id": categoryId,
        if (date != null && date.isNotEmpty) "date": date,
        if (time != null && time.isNotEmpty) "time": time,
        if (location != null && location.isNotEmpty) "location": location,
        if (title != null && title.isNotEmpty) "title": title,
        if (comment != null && comment.isNotEmpty) "comment": comment,
        if (subject != null && subject.isNotEmpty) "subject": subject,
        if (name != null && name.isNotEmpty) "name": name,
        if (address != null && address.isNotEmpty) "address": address,
        if (email != null && email.isNotEmpty) "email": email,
        if (mobile != null && mobile.isNotEmpty) "mobile": mobile,
        if (description != null && description.isNotEmpty)
          "description": description,
        if (reminderDate != null && reminderDate.isNotEmpty)
          "reminder_date": reminderDate,
        "addedby": addedBy,
        "addedtype": addedType,
        "account_id": accountId
      });
      dynamic response =
          await _apiServices.postApi(data, CasesUrl.addCases, isJson: true);

      if (response != null && response["status"] == true) {
        ApiModel res = ApiModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ApiModel>> addDocument({
    String? accountId,
    String? type,
    String? caseId,
    String? document,
    String? imageData,
    String? createdUserId,
  }) async {
    try {
      var body = json.encode({
        "type": type,
        "account_id": accountId,
        "case_id": caseId,
        "document": document,
        "image_data": imageData,
        "created_user_id": createdUserId,
        "app_version_code": "",
        "source": "web"
      });
      dynamic response =
          await _apiServices.postApi(body, CasesUrl.addDocument, isJson: true);

      if (response != null && response["status"] == true) {
        ApiModel res = ApiModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ApiModel>> addContactPerson(
      List<AddPersonModel> contactPerson) async {
    try {
      var body = json.encode(contactPerson);
      dynamic response = await _apiServices
          .postApi(body, CasesUrl.addContactPerson, isJson: true);

      if (response != null && response["status"] == true) {
        ApiModel res = ApiModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  //detail view
  Future<Either<Failure, CasesDetailModel>> getCaseDetails({
    String? accountId,
    String? type,
    String? id,
  }) async {
    try {
      var body = {
        "type": type,
        "account_id": accountId,
        "id": id,
      };
      dynamic response =
          await _apiServices.postApi(body, CasesUrl.viewCaseDetails);

      if (response != null && response["status"] == true) {
        CasesDetailModel res = CasesDetailModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ApiModel>> updateStatus(
      {String? id,
      String? status,
      String? remark,
      String? accountId,
      String? type,
      String? reminderDate,
      String? document,
      String? fileData,
      String? createdUserId}) async {
    try {
      var body = {
        "id": id,
        "status": status,
        if (remark != null) "remark": remark,
        "account_id": accountId,
        if (reminderDate != null) "reminder_date": reminderDate,
        if (document != null) "document": document,
        "type": type,
        "created_user_id": createdUserId,
        if (fileData != null) "document_file": fileData
      };
      dynamic response =
          await _apiServices.putApi(body, CasesUrl.updateCaseStatus);

      if (response != null && response["status"] == true) {
        ApiModel res = ApiModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
