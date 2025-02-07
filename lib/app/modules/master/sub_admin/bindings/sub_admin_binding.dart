import 'package:get/get.dart';

import '../controllers/sub_admin_controller.dart';

class SubAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubAdminController>(
      () => SubAdminController(),
    );
  }
}
