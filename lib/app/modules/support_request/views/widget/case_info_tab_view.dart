import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/modules/support_request/controllers/support_request_controller.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class CaseInfoTabView extends GetView<SupportRequestController> {
  final BoxConstraints cons;
  const CaseInfoTabView({super.key, required this.cons});

  @override
  Widget build(BuildContext context) {
    final width = cons.maxWidth * 0.46;
    return Form(

      key: controller.formkey1,
      child: SimpleContainer(
          child: SingleChildScrollView(
        child: Wrap(
          spacing: Responsive.isDesktop(context) ? 2.5.w : 1.5.w,
          runSpacing: Responsive.isDesktop(context) ? 1.8.w : 1.5.w,
          alignment: WrapAlignment.start,
          runAlignment: WrapAlignment.start,
          children: [
            Obx(
              () => DropDown3Widget(
                width: width,
                hint: '--Choose Category--',
                selectedItem: controller.addCategoryDrop.id == null
                    ? null
                    : controller.addCategoryDrop,
                items:
                    controller.categoryDropList.where((e) => e.id != '').toList(),
                isLoading: controller.isDropLoading.value,
                onChanged: (data) async {
                  if (data == null) return;
                  controller.addCategoryDrop = data;
                },
              validator: (value) {
                  if (value == null) {
                    return 'Please select an Category';
                  }
                  return null;
                },
              ),
            ),
            Obx(
              () => DropDown3Widget(
                width: width,
                hint: '--Choose Priority--',
                isLoading: controller.isDropLoading.value,
                selectedItem: controller.addPriorityDrop.id == null
                    ? null
                    : controller.addPriorityDrop,
                items:
                    controller.priorityDropList.where((e) => e.id != '').toList(),
                onChanged: (data) async {
                  if (data == null) return;
                  controller.addPriorityDrop = data;
                },
              ),
            ),
            Obx(
              () => DropDown3Widget(
                width: width,
                hint: '--Choose Assembly--',
                selectedItem: controller.addAssemblyDrop.id == null
                    ? null
                    : controller.addAssemblyDrop,
                items:
                    controller.assemblyDropList.where((e) => e.id != '').toList(),
                isLoading: controller.isDropLoading.value,
                onChanged: (data) async {
                  if (data == null) return;
                  controller.addAssemblyDrop = data;
                },
                 validator: (value) {
                  if (value == null) {
                    return 'Please select an assembly';
                  }
                  return null;
                },
              ),
            ),
            AddTextFieldWidget(
              width: width,
              labelText: 'Date',
              hintText: 'YYYY-MM-DD',
              // readonly: true,
              suffixIcon: IconButton(
                icon: const Icon(Icons.calendar_today_outlined, size: 20),
                onPressed: () async {
                  selectDate(context, controller.dateController);
                },
              ),
                 validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter';
                }
                return null;
              },
              textController: controller.dateController,
            ),
            AddTextFieldWidget(
              width: width,
              labelText: 'Case Title',
              hintText: 'Case Title',
              textController: controller.caseTitleController,
            ),
            AddTextFieldWidget(
              width: width,
              labelText: 'Add Comment',
              hintText: 'Add Comment',
              textController: controller.commentController,
            ),
            AddTextFieldWidget(
              width: double.infinity,
              labelText: 'Case Subject',
              hintText: 'Case Subject',
              minLines: 4,
              textController: controller.caseSubController,
            ),
            AddTextFieldWidget(
              width: width,
              labelText: 'Upload Documents',
              hintText: 'Upload Documents',
              readonly: true,
              suffixIcon: IconButton(
                  onPressed: () {
                    Get.bottomSheet(
                      PickImageBottomsheet(
                        pickMedia: (ImageSource? value, String? type) {
                          controller.pickImage(value, type!, "support");
                          Get.back();
                        },
                      ),
                      elevation: 20.0,
                      enableDrag: false,
                      isDismissible: true,
                      backgroundColor: Colors.white,
                      shape: bootomSheetShape(),
                    );
                  },
                  icon: Icon(Icons.upload_outlined)),
              textController: controller.uploadController,
            ),
            // 10.width,
            Align(
                alignment: Alignment.centerRight,
                child: CommonButton(
                    width: width,
                    isLoading: controller.isLoading.value,
                    onClick: () {
                      if (controller.formkey1.currentState!.validate()) {
                        controller.addSupportRequest();
                      }
                    },
                    label: 'ADD'))
          ],
        ).paddingSymmetric(horizontal: 10, vertical: 15),
      )),
    );
  }
}
