import 'package:dartz/dartz.dart';
import 'package:kc_venugopal_flutter_web/app/core/failure/failure.dart';
import 'package:kc_venugopal_flutter_web/app/data/app_url/dashboard/dashboard_url.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/dashboard/todays_activity_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/dashboard/upcoming_activity_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';

class DashboardRepository {
  final _apiServices = NetworkApiServices();

  Future<Either<Failure, TodaysActivityModel>> getTodayActivity(
      {String? type, String? accountId,String? activity}) async {
    try {
      dynamic response = await _apiServices.getApi(
          "${DashboardUrl.dashTodayActivity}?type=$type&account_id=$accountId&activity=$activity");
      if (response != null && response["status"] == true) {
        TodaysActivityModel res = TodaysActivityModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  Future<Either<Failure, UpcomingActivityModel>> getUpcomingActivity(
      {String? type, String? accountId}) async {
    try {
      dynamic response = await _apiServices.getApi(
          "${DashboardUrl.dashUpcomingActivity}?type=$type&account_id=$accountId");
      if (response != null && response["status"] == true) {
        UpcomingActivityModel res = UpcomingActivityModel.fromJson(response);

        return Right(res);
      } else {
        return Left(Failure(response["message"].toString()));
      }
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
