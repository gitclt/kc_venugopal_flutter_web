import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/support_request/controllers/support_request_detail_controller.dart';

import '../controllers/support_request_controller.dart';

class SupportRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SupportRequestController>(
      () => SupportRequestController(),
    );
    Get.lazyPut<SupportRequestDetailController>(
      () => SupportRequestDetailController(),
    );
  }
}
