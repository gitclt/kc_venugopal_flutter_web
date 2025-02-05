import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

class ContentPlaceWidget extends StatelessWidget {
  const ContentPlaceWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(builder: (context, delegate, currentRoute) {
     

      return GetRouterOutlet(
        initialRoute: Routes.DASHBOARD,
        // anchorRoute: Routes.HOME,
        key: Get.nestedKey(Routes.HOME),
      );
    });
  }
}
