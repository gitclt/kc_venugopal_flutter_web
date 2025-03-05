import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_detail_controller.dart';

import '../controllers/program_schedule_controller.dart';

class ProgramScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgramScheduleController>(
      () => ProgramScheduleController(),
    );
     Get.lazyPut<ProgramScheduleDetailController>(
      () => ProgramScheduleDetailController(),
    );
  }
}
