import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/master/master_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/api_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/subAdmin/add_subadmin_assembly.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/subAdmin/subadmin_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';

class SubadminRepository {
  final _apiServices = NetworkApiServices();

  Future<Either<Failure, ApiModel>> addSubAdmin(
      {String? name,
      String? accountId,
      String? username,
      String? password,
      String? contact,
      String? mobile,
      String? status}) async {
    try {
      var data = json.encode({
        "name": name,
        "account_id": accountId,
        "username": username,
        "password": password,
        "contact_person": contact,
        "mobile": mobile,
        "active_status": status
      });
      dynamic response =
          await _apiServices.postApi(data, MasterUrl.addSubAdmin, isJson: true);

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

  Future<Either<Failure, ApiModel>> addSubAdminAssembly(
      {List<AddSubAdminAssemblyModel>? data
     }) async {
    try {
      final body = json.encode(data);

      dynamic response =
          await _apiServices.postApi(body, MasterUrl.addSubadminAssemly, isJson: true);

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

  Future<Either<Failure, SubadminModel>> getSubAdmin(String accountId) async {
    try {
      dynamic response = await _apiServices.getApi(
        '${MasterUrl.subAdminListApi}?account_id=$accountId',
      );

      if (response != null && response["status"] == true) {
        SubadminModel res = SubadminModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ApiModel>> editSubAdmin(
      {required String id,
      required String name,
      String? username,
      String? password,
      String? status,
      String? contactPerson,
      String? mobile,
      required String accountId}) async {
    try {
      var data = json.encode({
        "id": id,
        "name": name,
        "account_id": accountId,
        "username": username,
        "password": password,
        "active_status": status,
        "contact_person": contactPerson,
        "mobile": mobile,
      });
      dynamic response = await _apiServices
          .putApi(data, MasterUrl.updateSubAdmin, isJson: true);

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

  //delete subadmin
  Future<Either<Failure, ApiModel>> deleteSubAdmin({
    required String id,
  }) async {
    var body = {"id": id};
    try {
      dynamic response =
          await _apiServices.deleteApi(body, MasterUrl.deleteSubAdmin);

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

   //delete subadmin assembly
  Future<Either<Failure, ApiModel>> deleteSubAdminAssembly({
    required String id,
  }) async {
    var body = {"id": id};
    try {
      dynamic response =
          await _apiServices.deleteApi(body, MasterUrl.deleteSubAdminAssembly);

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
