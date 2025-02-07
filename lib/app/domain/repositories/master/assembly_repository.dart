import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/master/master_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/api_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/master/assembly_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';

class AssemblyRepository {
  final _apiServices = NetworkApiServices();

  Future<Either<Failure, ApiModel>> addAssembly(
      {String? name, String? accountId}) async {
    try {
      var data = json.encode({"name": name, "account_id": accountId});
      dynamic response =
          await _apiServices.postApi(data, MasterUrl.addAssembly, isJson: true);

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

  Future<Either<Failure, AssemblyModel>> getAssembly(String accountId) async {
    try {
      dynamic response = await _apiServices.getApi(
        '${MasterUrl.assemblyListApi}?account_id=$accountId',
      );

      if (response != null && response["status"] == true) {
        AssemblyModel res = AssemblyModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, ApiModel>> editAssembly(
      {required String id,
      required String name,
      required String accountId}) async {
    try {
      var data = json.encode({"id": id, "name": name, "account_id": accountId});
      dynamic response = await _apiServices
          .putApi(data, MasterUrl.updateAssembly, isJson: true);

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

  //delete
  Future<Either<Failure, ApiModel>> deleteAssembly({
    required String id,
  }) async {
    var body = {"id": id};
    try {
      dynamic response =
          await _apiServices.deleteApi(body, MasterUrl.deleteAssembly);

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
