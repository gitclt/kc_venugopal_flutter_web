import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/dashboard/todays_activity_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/dashboard/dashboard_repository.dart';

class AllActivityController extends GetxController {
  final isLoading = false.obs;
  var selectedType = ''.obs;
  var pageIndex = 1.obs;
  var pageSize = 10.obs;
  var totalCount = 1.obs;
  RxList<CasesData> activityData = <CasesData>[].obs;
  RxList<TodaysData> todaysData = <TodaysData>[].obs;
  late DateTime fromDate;
  late DateTime toDate;
  final repo = CasesRepository();
  final dashRepo = DashboardRepository();
  var date = '';
  var type = '';
  var timeRange = '';

  @override
  void onInit() {
    super.onInit();
    if (Get.rootDelegate.arguments() != null) {
      var args = Get.rootDelegate.arguments();
      date = args['date'] ?? '';
      type = args['type'] ?? '';
      timeRange = args['timeRange'] ?? '';
      if (type != '') {
        selectedType.value = type;
      }
      print(date);
      print(selectedType);
    }
    constValues();

    getTodaysActivities();
  }

  constValues() {
    DateTime now = DateTime.now();

    // Start of the current month
    fromDate = DateTime(now.year, now.month, 1);

    // End of the current month
    toDate = DateTime(now.year, now.month + 1);
  }

  void getTodaysActivities() async {
    isLoading(true);
    todaysData.clear();
    final response = await dashRepo.getTodayActivity(
        type: "web",
        accountId: LocalStorageKey.userData.accountId.toString(),
        activity: "today");
    response.fold((failure) {
      isLoading(false);
    }, (resData) async {
      isLoading(false);
      if (resData.data != null) {
        todaysData.addAll(resData.data!);

        await getActivityData(type: type);
      }
    });
  }

  void updateSelectedType(String type) {
    selectedType.value = type;
    getActivityData(type: type);
  }

  Future<void> getActivityData({String? type}) async {
    isLoading(true);
    activityData.clear();
    String assemblyId = LocalStorageKey.userData.assemblyId.toString();

    final response = await repo.getCasesList(
        accountId: LocalStorageKey.userData.accountId.toString(),
        page: pageSize.value == 0 ? '0' : pageIndex.value.toString(),
        pageSize: pageSize.value == 0 ? '0' : pageSize.value.toString(),
        timeRange: timeRange != '' ? timeRange : '',
        type: type,
        assemblyId: LocalStorageKey.userData.type == 'subadmin' ? assemblyId : null,
        date: date);
    response.fold((failure) {
      isLoading(false);
    }, (resData) {
      isLoading(false);
      if (pageSize.value != 0) {
        totalCount.value =
            (int.parse(resData.totalCount!) / pageSize.value).ceil();
      }
      if (resData.data != null) {
        activityData.addAll(resData.data!);
      }
    });
  }

  void changePage(int page) {
    if (page > 0 && page <= totalCount.value) {
      pageIndex.value = page; // Update current page
      getActivityData(); // Fetch the employee list for the new page
    }
  }
}
