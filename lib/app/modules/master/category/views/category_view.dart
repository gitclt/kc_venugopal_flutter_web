import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

import '../controllers/category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        HomeAppBar(
          title: 'Category',
          subTitle: 'Home > Master > Category',
          isAdd: true,
          onClick: () {
            Get.rootDelegate.toNamed(Routes.ADD_CATEGORY);
          },
        )
      ],
    ));
  }
}
