import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/check_box_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/reminder/controllers/reminder_controller.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/table/contact_person_view.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class ReminderAddView extends GetView<ReminderController> {
  const ReminderAddView({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.37;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: CommonPagePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HomeAppBar(
              title: 'Add Reminder',
              subTitle: 'Home > Dashboard >Add Reminder',
              onClick: () {
                Get.rootDelegate.toNamed(Routes.REMINDER);
              },
            ),
            20.height,
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: SimpleContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing:
                                Responsive.isDesktop(context) ? 2.5.w : 2.w,
                            runSpacing:
                                Responsive.isDesktop(context) ? 2.w : 1.8.w,
                            alignment: WrapAlignment.start,
                            children: [
                              Obx(
                                () => DropDown3Widget(
                                  width: width,
                                  hint: '--Choose Type--',
                                  selectedItem:
                                      controller.addTypeDrop.id == null
                                          ? null
                                          : controller.addTypeDrop,
                                  items: controller.typeDropList,
                                  isLoading: controller.isDropLoading.value,
                                  onChanged: (data) async {
                                    if (data == null) return;
                                    controller.addTypeDrop = data;
                                  },
                                ),
                              ),
                              Obx(
                                () => DropDown3Widget(
                                  width: width,
                                  hint: '--Choose Assembly--',
                                  selectedItem:
                                      controller.addAssemblyDrop.id == null
                                          ? null
                                          : controller.addAssemblyDrop,
                                  items: controller.assemblyDropList,
                                  isLoading: controller.isDropLoading.value,
                                  onChanged: (data) async {
                                    if (data == null) return;
                                    controller.addAssemblyDrop = data;
                                  },
                                ),
                              ),
                              Obx(
                                () => DropDown3Widget(
                                  width: width,
                                  hint: '--Choose Priority--',
                                  isLoading: controller.isDropLoading.value,
                                  selectedItem:
                                      controller.addPriorityDrop.id == null
                                          ? null
                                          : controller.addPriorityDrop,
                                  items: controller.priorityDropList,
                                  onChanged: (data) async {
                                    if (data == null) return;
                                    controller.addPriorityDrop = data;
                                  },
                                ),
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Date',
                                hintText: 'DD/MM/YYYY',
                                // readonly: true,
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20),
                                  onPressed: () async {
                                    selectDate(
                                        context, controller.dateController);
                                  },
                                ),
                                textController: controller.dateController,
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Time',
                                hintText: 'Time',
                                suffixIcon: IconButton(
                                  icon: svgWidget(SvgAssets.casesTime),
                                  onPressed: () async {
                                    selectTime(
                                        context, controller.timeController);
                                  },
                                ),
                                textController: controller.timeController,
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Location',
                                hintText: 'Location',
                                textController: controller.locationController,
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Title',
                                hintText: 'Title',
                                textController: controller.titleController,
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Description',
                                hintText: 'Description',
                                textController: controller.descriptController,
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Documents',
                                hintText: 'Upload Documents',
                                textController: controller.uploadController,
                                readonly: true,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      Get.bottomSheet(
                                        PickImageBottomsheet(
                                          pickImage: (ImageSource? value) {
                                            if (value != null) {
                                              controller.pickImage(
                                                  value, 'reminder');
                                              Get.back();
                                            }
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
                              ),
                            ],
                          ),
                          15.height,
                          columnText('Contact Person Details', 18)
                              .paddingOnly(left: 5),
                          10.height,
                          // Wrap(
                          //   spacing:
                          //       Responsive.isDesktop(context) ? 2.5.w : 2.w,
                          //   runSpacing:
                          //       Responsive.isDesktop(context) ? 2.w : 1.8.w,
                          //   children: [
                          //     AddTextFieldWidget(
                          //       width: width,
                          //       labelText: 'Name',
                          //       hintText: 'Name',
                          //       textController: controller.nameController,
                          //     ),
                          //     AddTextFieldWidget(
                          //       width: width,
                          //       labelText: 'Mobile',
                          //       hintText: 'Mobile',
                          //       textController: controller.mobileController,
                          //     ),
                          //     AddTextFieldWidget(
                          //       width: width,
                          //       labelText: 'Designation',
                          //       hintText: 'Designation',
                          //       textController: controller.desigController,
                          //     ),

                          ContactPersonView(),
                          //   ],
                          // ),
                          20.height,
                          Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CheckBoxButton(
                                          selectItem:
                                              controller.isReminder.value,
                                          act: () {
                                            controller.isReminder.value =
                                                !controller.isReminder.value;
                                          }),
                                      5.width,
                                      columnText('Set Reminder', 14)
                                    ],
                                  ),
                                  5.height,
                                  controller.isReminder.value
                                      ? AddTextFieldWidget(
                                          width: width,
                                          //labelText: 'Designation',
                                          hintText: 'DD/MM/YYYY',
                                          textController:
                                              controller.remindDateController,
                                        )
                                      : const SizedBox(),
                                ],
                              ).paddingOnly(left: 5)),
                          15.height,
                          Obx(
                            () => Align(
                                alignment: Alignment.bottomRight,
                                child: CommonButton(
                                    isLoading: controller.isLoading.value,
                                    width: width,
                                    onClick: () {
                                      controller.addReminder();
                                    },
                                    label: 'ADD')),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
