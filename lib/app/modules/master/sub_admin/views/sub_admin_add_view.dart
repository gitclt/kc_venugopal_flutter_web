import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/check_box_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/master/sub_admin/controllers/sub_admin_controller.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class SubAdminAddView extends GetView<SubAdminController> {
  const SubAdminAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: CommonPagePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(
              title: 'Sub Admin',
              subTitle: 'Home > Master > Sub Admin',
              onClick: () {
                Get.rootDelegate.toNamed(Routes.SUB_ADMIN);
              },
            ),
            20.height,
            Form(
              key: controller.formkey,
              child: Wrap(
                  spacing: Responsive.isDesktop(context)
                      ? 1.8.w
                      : 2.w, // Horizontal spacing
                  runSpacing: 15,
                  children: [
                    AddTextFieldWidget(
                      textController: controller.nameController,
                      hintText: 'Name',
                      labelText: 'Name',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                    ),
                    AddTextFieldWidget(
                      textController: controller.userNameController,
                      hintText: 'UserName',
                      labelText: 'UserName',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter UserName';
                        }
                        return null;
                      },
                    ),
                    AddTextFieldWidget(
                      textController: controller.passwordController,
                      hintText: 'Password',
                      labelText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                    AddTextFieldWidget(
                      textController: controller.contactController,
                      hintText: 'Contact Person',
                      labelText: 'Contact Person',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Contact Person';
                        }
                        return null;
                      },
                    ),
                    AddTextFieldWidget(
                      textController: controller.mobileController,
                      hintText: 'Mobile',
                      labelText: 'Mobile',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Mobile';
                        }
                        return null;
                      },
                    ),
                  ]),
            ),
            15.height,
            boldText('Select Assembly'),
            10.height,
            Wrap(
              spacing: 15,
              children: controller.assemblyData
                  .map(
                    (item) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Row(
                        children: [
                          Obx(
                            () => CheckBoxButton(
                              selectItem: item.isSelect!.value,
                              act: () {
                                item.isSelect!.value = !item.isSelect!.value;
                              },
                            ),
                          ),
                          8.width,
                          columnText(item.name.toString(), 11.sp)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
            20.height,
            Align(
              alignment: Alignment.bottomRight,
              child: CommonButton(
                isLoading: controller.isLoading.value,
                width: Responsive.isDesktop(context) ? 15.w : 20.w,
                onClick: () {
                  if (controller.formkey.currentState!.validate()) {
                    if (controller.editId == '') {
                      controller.addSubAdmin();
                    } else {
                      controller.editSubAdmin();
                    }
                  }
                },
                label: controller.editId == '' ? 'Create' : 'Update',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
