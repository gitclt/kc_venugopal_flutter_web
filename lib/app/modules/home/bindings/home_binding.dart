import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/cases/controllers/cases_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<CasesController>(
      () => CasesController(),
    );
  }
}
