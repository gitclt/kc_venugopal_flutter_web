import 'package:get/get.dart';

import '../controllers/assembly_controller.dart';

class AssemblyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssemblyController>(
      () => AssemblyController(),
    );
  }
}
