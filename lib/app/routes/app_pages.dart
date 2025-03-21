import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/dashboard/views/activity_detail_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/views/program_schedule_detail_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/reminder/views/reminder_add_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/reminder/views/reminder_detail_view.dart';

import '../modules/cases/bindings/cases_binding.dart';
import '../modules/cases/views/cases_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/master/assembly/bindings/assembly_binding.dart';
import '../modules/master/assembly/views/assembly_add_view.dart';
import '../modules/master/assembly/views/assembly_view.dart';
import '../modules/master/category/bindings/category_binding.dart';
import '../modules/master/category/views/category_add_view.dart';
import '../modules/master/category/views/category_view.dart';
import '../modules/master/priority/bindings/priority_binding.dart';
import '../modules/master/priority/views/priority_add_view.dart';
import '../modules/master/priority/views/priority_view.dart';
import '../modules/master/sub_admin/bindings/sub_admin_binding.dart';
import '../modules/master/sub_admin/views/sub_admin_add_view.dart';
import '../modules/master/sub_admin/views/sub_admin_view.dart';
import '../modules/program_schedule/bindings/program_schedule_binding.dart';
import '../modules/program_schedule/views/program_schedule_add_view.dart';
import '../modules/program_schedule/views/program_schedule_view.dart';
import '../modules/reminder/bindings/reminder_binding.dart';
import '../modules/reminder/views/reminder_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/support_request/bindings/support_request_binding.dart';
import '../modules/support_request/views/support_request_add_view.dart';
import '../modules/support_request/views/support_request_detail_view.dart';
import '../modules/support_request/views/support_request_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
        name: _Paths.ROOT,
        page: () => const RootView(),
        binding: RootBinding(),
        participatesInRootNavigator: true,
        transition: Transition.noTransition,
        preventDuplicates: true,
        children: [
          GetPage(
            name: _Paths.LOGIN,
            page: () => const LoginView(),
            binding: LoginBinding(),
            transition: Transition.fade,
          ),
          GetPage(
            name: _Paths.HOME,
            page: () => HomeView(),
            transition: Transition.noTransition,
            bindings: [
              HomeBinding(),
            ],
            title: null,
            children: [
              GetPage(
                name: _Paths.DASHBOARD,
                page: () => const DashboardView(),
                binding: DashboardBinding(),
                transition: Transition.noTransition,
                children: [
                  GetPage(
                    name: _Paths.ALL_ACTIVITIES,
                    page: () => const ActivityDetailView(),
                    transition: Transition.noTransition,
                    binding: DashboardBinding(),
                  )
                ],
              ),
              GetPage(
                  name: _Paths.CATEGORY,
                  page: () => const CategoryView(),
                  transition: Transition.noTransition,
                  binding: CategoryBinding(),
                  children: [
                    GetPage(
                      name: _Paths.ADD_CATEGORY,
                      page: () => const CategoryAddView(),
                      transition: Transition.noTransition,
                      binding: CategoryBinding(),
                    )
                  ]),
              GetPage(
                  name: _Paths.PRIORITY,
                  page: () => const PriorityView(),
                  transition: Transition.noTransition,
                  binding: PriorityBinding(),
                  children: [
                    GetPage(
                      name: _Paths.ADD_PRIORITY,
                      page: () => const PriorityAddView(),
                      transition: Transition.noTransition,
                      binding: PriorityBinding(),
                    )
                  ]),
              GetPage(
                  name: _Paths.ASSEMBLY,
                  page: () => const AssemblyView(),
                  transition: Transition.noTransition,
                  binding: AssemblyBinding(),
                  children: [
                    GetPage(
                      name: _Paths.ADD_ASSEMBLY,
                      page: () => const AssemblyAddView(),
                      transition: Transition.noTransition,
                      binding: AssemblyBinding(),
                    )
                  ]),
              GetPage(
                  name: _Paths.SUB_ADMIN,
                  page: () => const SubAdminView(),
                  transition: Transition.noTransition,
                  binding: SubAdminBinding(),
                  children: [
                    GetPage(
                      name: _Paths.ADD_SUB_ADMIN,
                      page: () => const SubAdminAddView(),
                      transition: Transition.noTransition,
                      binding: SubAdminBinding(),
                    )
                  ]),
              GetPage(
                  name: _Paths.SUPPORT_REQUEST,
                  page: () => const SupportRequestView(),
                  binding: SupportRequestBinding(),
                  transition: Transition.noTransition,
                  children: [
                    GetPage(
                      name: _Paths.ADD_SUPPORT_REQUEST,
                      page: () => const SupportRequestAddView(),
                      transition: Transition.noTransition,
                      binding: SupportRequestBinding(),
                    ),
                    GetPage(
                      name: _Paths.SUPPORT_REQUEST_DETAIL,
                      page: () => const SupportRequestDetailView(),
                      transition: Transition.noTransition,
                      binding: SupportRequestBinding(),
                    ),
                  ]),
              GetPage(
                  name: _Paths.PROGRAM_SCHEDULE,
                  page: () => const ProgramScheduleView(),
                  binding: ProgramScheduleBinding(),
                  transition: Transition.noTransition,
                  children: [
                    GetPage(
                      name: _Paths.ADD_PROGRAM_SCHEDULE,
                      page: () => const ProgramScheduleAddView(),
                      binding: ProgramScheduleBinding(),
                      transition: Transition.noTransition,
                    ),
                    GetPage(
                      name: _Paths.PROGRAM_SCHEDULE_DETAIL,
                      page: () => const ProgramScheduleDetailView(),
                      transition: Transition.noTransition,
                      binding: ProgramScheduleBinding(),
                    ),
                  ]),
              GetPage(
                  name: _Paths.REMINDER,
                  page: () => const ReminderView(),
                  binding: ReminderBinding(),
                  transition: Transition.noTransition,
                  children: [
                    GetPage(
                      name: _Paths.ADD_REMINDER,
                      page: () => const ReminderAddView(),
                      binding: ReminderBinding(),
                      transition: Transition.noTransition,
                    ),
                    GetPage(
                      name: _Paths.REMINDER_DETAIL,
                      page: () => const ReminderDetailView(),
                      binding: ReminderBinding(),
                      transition: Transition.noTransition,
                    )
                  ]),
            ],
          ),
          GetPage(
            name: _Paths.CASES,
            page: () => const CasesView(),
            binding: CasesBinding(),
          ),
        ]),
  ];
}
