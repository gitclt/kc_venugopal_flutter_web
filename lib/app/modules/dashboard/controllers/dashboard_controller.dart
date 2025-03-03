import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/dashboard/upcoming_activity_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/dashboard/dashboard_repository.dart';

class DashboardController extends GetxController {
  final isLoading = false.obs;
  final dashRepo = DashboardRepository();
  var supportCount = '';
  var supportRemindCount = '';
  var programCount = '';
  var programRemindCount = '';
  var weddingCount = '';
  var weddingRemindCount = '';
  var birthdayCount = '';
  var birthdayRemindCount = '';
  RxList<Reminder> upcomingReminders = <Reminder>[].obs;

  @override
  void onInit() {
    super.onInit();
    getTodaysActivities();
    getUpcomingActivities();
  }

  void getTodaysActivities() async {
    isLoading(true);
    final response = await dashRepo.getTodayActivity(
        type: "web",
        accountId: LocalStorageKey.userData.accountId.toString(),
        activity: "today");
    response.fold((failure) {
      isLoading(false);
    }, (resData) {
      isLoading(false);
      if (resData.data != null) {
        supportCount = resData.data!.supportrequest ?? '';
        supportRemindCount = resData.data!.supportrequestReminders ?? '';
        programCount = resData.data!.programschedule ?? '';
        programRemindCount = resData.data!.programscheduleReminders ?? '';
        weddingCount = resData.data!.wedding ?? '';
        weddingRemindCount = resData.data!.weddingReminders ?? '';
        birthdayCount = resData.data!.birthday ?? '';
        birthdayRemindCount = resData.data!.birthdayReminders ?? '';
      }
    });
  }

  void getUpcomingActivities() async {
    isLoading(true);
    upcomingReminders.clear();
    final response = await dashRepo.getUpcomingActivity(
        type: "web", accountId: LocalStorageKey.userData.accountId.toString());
    response.fold((failure) {
      isLoading(false);
    }, (resData) {
      isLoading(false);
      if (resData.status!) {
        upcomingReminders.addAll(resData.reminders!);
      }
    });
  }
}
