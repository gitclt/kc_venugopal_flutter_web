import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/cases/cases_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/api_model.dart';
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
      String? assemblyId,
      String? keyword}) async {
    try {
      var body = {
        "account_id": accountId,
        "page": page,
        "pageSize": pageSize,
        "type": type,
        "fromdate": fromDate,
        "todate": toDate,
        "status": status,
        "category_id": categoryId,
        "priority_id": priorityId,
        "timeRange": timeRange ?? '',
        "month": month ?? '',
        "assembly_id":assemblyId,
        "keyword": keyword
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
        "assembly_id": assemblyId,
        "priority_id": priorityId,
        "category_id": categoryId,
        "date": date,
        "time": time,
        "location": location,
        "title": title,
        "comment": comment,
        "subject": subject,
        "name": name,
        "address": address,
        "email": email,
        "mobile": mobile,
        "description": description,
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

  Future<Either<Failure, ApiModel>> addContactPerson({
    String? accountId,
    String? type,
    String? name,
    String? designation,
    String? mobile,
    String? caseId,
  }) async {
    try {
      var body = json.encode({
        "type": type,
        "account_id": accountId,
        "case_id": caseId,
        "name": name,
        "designation": designation,
        "mobile": mobile,
      });
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
        "remark": remark,
        "account_id": accountId,
        "reminder_date": reminderDate,
        "document": document,
        "type": type,
        "created_user_id": createdUserId,
        "document_file": fileData
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
