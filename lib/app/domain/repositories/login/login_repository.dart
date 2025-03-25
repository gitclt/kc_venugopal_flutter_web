import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/auth/auth_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/auth/auth_model.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<Either<Failure, AuthModel>> loginApi(var data) async {
    try {
      var formData = {
        "data": data,
      };
      dynamic response = await _apiService.loginApi(
        formData,
        AppAuthUrl.login,
      );

      if (response != null && response["status"] == true) {
        AuthModel user = AuthModel.fromJson(response);

        return Right(user);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
