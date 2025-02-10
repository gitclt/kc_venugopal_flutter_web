import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/master/assembly/views/assembly_add_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/master/category/views/category_add_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/master/priority/views/priority_add_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/master/sub_admin/views/sub_admin_add_view.dart';

import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/master/assembly/bindings/assembly_binding.dart';
import '../modules/master/assembly/views/assembly_view.dart';
import '../modules/master/category/bindings/category_binding.dart';
import '../modules/master/category/views/category_view.dart';
import '../modules/master/priority/bindings/priority_binding.dart';
import '../modules/master/priority/views/priority_view.dart';
import '../modules/master/sub_admin/bindings/sub_admin_binding.dart';
import '../modules/master/sub_admin/views/sub_admin_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

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
                children: const [],
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
            ],
          ),
        ])
  ];
}
