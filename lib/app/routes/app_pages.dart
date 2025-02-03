import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/root/bindings/root_binding.dart';
import 'package:kc_venugopal_flutter_web/app/modules/root/views/root_view.dart';
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
        
      ]
    )
  ];
}
