import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';
import '../controllers/category_controller.dart';

class CategoryAddView extends GetView<CategoryController> {
  const CategoryAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        HomeAppBar(
          title: 'Category',
          subTitle: 'Home > Master > Category',
          onClick: () {
            Get.rootDelegate.toNamed(Routes.CATEGORY);
          },
        ),
        20.height,
        Form(
          key: controller.formkey,
          child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              spacing: Responsive.isDesktop(context)
                  ? 10.w
                  : Responsive.isMobile(context)
                      ? 10.w
                      : 20.w,
              // runSpacing: 15,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddTextFieldWidget(
                      width: Responsive.isDesktop(context) ? 10.w : 5.w,
                      textController: controller.nameController,
                      label: 'Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                    ).paddingOnly(left: 15),
                    20.width,
                    CommonButton(
                      isLoading: controller.isLoading.value,
                      width: Responsive.isDesktop(context) ? 10.w : 20.w,
                      onClick: () {
                        if (controller.formkey.currentState!.validate()) {
                          if (controller.editId == '') {
                            controller.addCategory();
                          } else {
                            controller.editCategory();
                          }
                        }
                      },
                      label: controller.editId == '' ? 'Create' : 'Update',
                    ).paddingOnly(right: 40),
                  ],
                ),
              ]),
        )
      ],
    ));
  }
}
