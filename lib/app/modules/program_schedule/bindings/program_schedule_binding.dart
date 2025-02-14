import 'package:get/get.dart';

import '../controllers/program_schedule_controller.dart';

class ProgramScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgramScheduleController>(
      () => ProgramScheduleController(),
    );
  }
}
