import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';
import '../controllers/priority_controller.dart';

class PriorityAddView extends GetView<PriorityController> {
  const PriorityAddView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.scaffoldBgColor,
        body: CommonPagePadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppBar(
                title: 'Priority',
                subTitle: 'Home > Master > Priority',
                onClick: () {
                  Get.rootDelegate.toNamed(Routes.PRIORITY);
                },
              ),
              20.height,
              Form(
                key: controller.formkey,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: AddTextFieldWidget(
                          width: double.infinity,
                          textController: controller.nameController,
                          label: 'Name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Name';
                            }
                            return null;
                          },
                        ).paddingOnly(left: 15),
                      ),
                      20.width,
                      CommonButton(
                        isLoading: controller.isLoading.value,
                        width: Responsive.isDesktop(context) ? 15.w : 12.w,
                        onClick: () {
                          if (controller.formkey.currentState!.validate()) {
                            if (controller.editId == '') {
                              controller.addPriority();
                            } else {
                              controller.editPriority();
                            }
                          }
                        },
                        label: controller.editId == '' ? 'Create' : 'Update',
                      ),
                    ]),
              )
            ],
          ),
        ));
  }
}
