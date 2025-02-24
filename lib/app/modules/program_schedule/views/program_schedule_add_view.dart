import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/check_box_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/table/contact_person_view.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_controller.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class ProgramScheduleAddView extends GetView<ProgramScheduleController> {
  const ProgramScheduleAddView({super.key});

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
              title: 'Add Program Schedule',
              subTitle: 'Home > Dashboard >Add Program Schedule',
              isAdd: true,
              onClick: () {
                Get.rootDelegate.toNamed(Routes.PROGRAM_SCHEDULE);
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
                                  hint: '--Choose Assembly--',
                                  selectedItem:
                                      controller.addAssemblyDrop.id == null
                                          ? null
                                          : controller.addAssemblyDrop,
                                  items: controller.categoryDropList,
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
                                  hint: '--Choose Category--',
                                  selectedItem:
                                      controller.addCategoryDrop.id == null
                                          ? null
                                          : controller.addCategoryDrop,
                                  items: controller.categoryDropList,
                                  isLoading: controller.isDropLoading.value,
                                  onChanged: (data) async {
                                    if (data == null) return;
                                    controller.addCategoryDrop = data;
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
                                        context, controller.fromDateController);
                                  },
                                ),
                                textController: controller.fromDateController,
                              ),
                              AddTextFieldWidget(
                                width: width,
                                labelText: 'Time',
                                hintText: 'Time',
                                suffixIcon: IconButton(
                                  icon: svgWidget(SvgAssets.casesTime),
                                  onPressed: () async {
                                    selectDate(
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
                                textController: controller.descriptController,
                              ),
                            ],
                          ),
                          15.height,
                          columnText('Contact Person Details', 18)
                              .paddingOnly(left: 5),
                          10.height,
                          ContactPersonView(),
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
                          Align(
                              alignment: Alignment.bottomRight,
                              child: CommonButton(
                                  width: width, onClick: () {
                                    
                                  }, label: 'ADD'))
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
