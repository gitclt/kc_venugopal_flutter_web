import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kc_venugopal_flutter_web/app/constants/const_values.dart';
import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/cases/cases_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/dashboard/todays_activity_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/model/dashboard/upcoming_activity_model.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/cases/cases_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/dashboard/dashboard_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardController extends GetxController {
  final isLoading = false.obs;
  final isRequestLoading = false.obs;

  final dashRepo = DashboardRepository();
  RxList<TodaysData> todaysData = <TodaysData>[].obs;
  RxList<Reminder> upcomingReminders = <Reminder>[].obs;
  RxList<CasesData> programData = <CasesData>[].obs;
  RxList<CasesData> supportData = <CasesData>[].obs;
  RxList<CasesData> activityData = <CasesData>[].obs;
  RxList<String> eventDates = <String>[].obs; // Stores only dates
  RxList<String> eventTypes = <String>[].obs;

  var currentMonth = DateTime.now();
  late DateTime fromDate;
  late DateTime toDate;

  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rxn<DateTime> selectedDay = Rxn<DateTime>(); // nullable DateTime
  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;
  Map<String, Set<String>> eventMap = {};

  final repo = CasesRepository();
  var assemblyId = '';

  @override
  void onInit() async {
    super.onInit();
    assemblyId =
        LocalStorageKey.userAssembly.map((e) => e.assemblyId).join(',');
    constValues();
    getEvents();
    getTodaysActivities();
    getUpcomingActivities();
    getProgramSchedules();
    getSupportRequest();
  }

  constValues() {
    DateTime now = DateTime.now();

    // Start of the current month
    fromDate = DateTime(now.year, now.month, 1);

    // End of the current month
    toDate = DateTime(now.year, now.month + 1);
  }

  getEvents() async {
    isLoading(true);
    eventMap.clear();

    final response = await repo.getCasesList(
      accountId: LocalStorageKey.userData.accountId.toString(),
      timeRange: 'month',
    );

    response.fold((failure) {
      isLoading(false);
    }, (resData) {
      isLoading(false);

      if (resData.data != null) {
        for (var value in resData.data!) {
          if (value.date != null && value.type != null) {
            String formattedDate =
                DateTime.parse(value.date!).toIso8601String().substring(0, 10);

            eventMap.putIfAbsent(formattedDate,
                () => <String>{}); // Initialize Set if not exists
            eventMap[formattedDate]!
                .add(value.type!); // Add all event types for the same date
          }
        }
      }
      update();
    });
  }

  // getEvents() async {
  //   isLoading(true);
  //   eventTypes.clear();
  //   eventDates.clear();

  //   final response = await repo.getCasesList(
  //     accountId: LocalStorageKey.userData.accountId.toString(),
  //     timeRange: 'month',
  //     // assemblyId:
  //     //     LocalStorageKey.userData.type == 'subadmin' ? assemblyId : null,
  //   );
  //   response.fold((failure) {
  //     isLoading(false);
  //   }, (resData) {
  //     isLoading(false);

  //     if (resData.data != null) {
  //       for (var value in resData.data!) {
  //         if (value.date != null && value.type != null) {
  //           String formattedDate =
  //               DateTime.parse(value.date!).toIso8601String().substring(0, 10);
  //           eventDates.add(formattedDate);
  //           eventTypes.add(value.type!);
  //         }
  //       }
  //     }
  //     update();
  //   });
  // }

  List<DateTime> getEventDays() {
    return eventDates
        .map((dateString) {
          try {
            return DateFormat('yyyy-MM-dd').parse(dateString);
          } catch (e) {
            print('Error parsing date: $dateString, error: $e');
            return DateTime(0);
          }
        })
        .where((date) => date != DateTime(0))
        .toList();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
  }

  /// Change selected type and update list

  void getTodaysActivities() async {
    isLoading(true);
    todaysData.clear();
    final response = await dashRepo.getTodayActivity(
        type: "web",
        accountId: LocalStorageKey.userData.accountId.toString(),
        activity: "today");
    response.fold((failure) {
      isLoading(false);
    }, (resData) {
      isLoading(false);
      if (resData.data != null) {
        todaysData.addAll(resData.data!);
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

  Future<void> getProgramSchedules() async {
    isRequestLoading(true);
    programData.clear();

    final response = await repo.getCasesList(
        accountId: LocalStorageKey.userData.accountId.toString(),
        page: '1',
        pageSize: '10',
        type: ConstValues.typeProgram,
        assemblyId:
            LocalStorageKey.userData.type == 'subadmin' ? assemblyId : null,
        fromDate: '',
        toDate: '');

    response.fold((failure) {
      isRequestLoading(false);
    }, (resData) {
      isRequestLoading(false);

      if (resData.data != null) {
        programData.addAll(resData.data!);
      }
    });
  }

  Future<void> getSupportRequest() async {
    isRequestLoading(true);
    supportData.clear();

    final response = await repo.getCasesList(
      accountId: LocalStorageKey.userData.accountId.toString(),
      page: '1',
      pageSize: '10',
      type: ConstValues.typeSupport,
      assemblyId:
          LocalStorageKey.userData.type == 'subadmin' ? assemblyId : null,
      fromDate: '',
      toDate: '',
    );
    response.fold((failure) {
      isRequestLoading(false);
    }, (resData) {
      isRequestLoading(false);

      if (resData.data != null) {
        supportData.addAll(resData.data!);
      }
    });
  }
}
