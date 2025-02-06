import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/auth/auth_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';
import 'package:kc_venugopal_flutter_web/app/model/auth/auth_model.dart';

class ProfileRepository {
  final _apiServices = NetworkApiServices();

  Future<Either<Failure, UserResponse>> getProfileView(String token) async {
    try {
      dynamic response = await _apiServices.getApi(
        "${AppAuthUrl.profileApi}?encKey=$token",
      );

      if (response != null && response["status"] == true) {
        UserResponse user = UserResponse.fromJson(response);

        return Right(user);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
