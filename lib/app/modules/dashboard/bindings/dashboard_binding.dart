import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/dashboard/controllers/all_activity_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );
     Get.lazyPut<AllActivityController>(
      () => AllActivityController(),
    );
  }
}
