import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        return Scaffold(
            backgroundColor: AppColor.primary,
            body:
                // Obx(
                // () => (!controller.isLoading)
                //     ? (controller.isAuthenticated)
                //         ? GetRouterOutlet(
                //             initialRoute: Routes.HOME,
                //           )
                //         :
                GetRouterOutlet(
              initialRoute: Routes.LOGIN,
            )
            // : _buildSplash(context),
            //  ),
            );
      },
    );
  }
}
