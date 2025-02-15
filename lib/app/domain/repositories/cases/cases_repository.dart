import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/cases/cases_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/api_model.dart';
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
}
