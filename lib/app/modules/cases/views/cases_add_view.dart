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
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/cases/controllers/cases_controller.dart';
import 'package:kc_venugopal_flutter_web/app/modules/support_request/views/support_request_add_view.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class CasesAddView extends GetView<CasesController> {
  const CasesAddView({super.key});

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
              title: controller.type.value.name == 'support request'
                  ? 'Add Support Requests'
                  : controller.type.value.name == 'program schedule'
                      ? 'Add Program Schedule'
                      : 'Add Reminders',
              subTitle:
                  'Home > Dashboard > ${controller.type.value.name == 'support request' ? 'Add Support Requests' : controller.type.value.name == 'program schedule' ? 'Add Program Schedule' : 'Add Reminders'}',
              isAdd: true,
              onClick: () {
                // Get.rootDelegate.toNamed(Routes.PROGRAM_SCHEDULE);
              },
            ),
            20.height,
            controller.type.value.name == 'support request'
                ? SupportRequestAddView()
                : Expanded(
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
                                  spacing: Responsive.isDesktop(context)
                                      ? 2.5.w
                                      : 2.w,
                                  runSpacing: Responsive.isDesktop(context)
                                      ? 2.w
                                      : 1.8.w,
                                  alignment: WrapAlignment.start,
                                  children: [
                                    Obx(
                                      () => DropDown3Widget(
                                        width: width,
                                        hint: '--Choose Assembly--',
                                        selectedItem:
                                            controller.addAssemblyDrop.id ==
                                                    null
                                                ? null
                                                : controller.addAssemblyDrop,
                                        items: controller.categoryDropList,
                                        isLoading:
                                            controller.isDropLoading.value,
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
                                            controller.addCategoryDrop.id ==
                                                    null
                                                ? null
                                                : controller.addCategoryDrop,
                                        items: controller.categoryDropList,
                                        isLoading:
                                            controller.isDropLoading.value,
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
                                        isLoading:
                                            controller.isDropLoading.value,
                                        selectedItem:
                                            controller.addPriorityDrop.id ==
                                                    null
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
                                          selectDate(context,
                                              controller.fromDateController);
                                        },
                                      ),
                                      textController:
                                          controller.fromDateController,
                                    ),
                                    AddTextFieldWidget(
                                      width: width,
                                      labelText: 'Time',
                                      hintText: 'Time',
                                      suffixIcon: IconButton(
                                        icon: svgWidget(SvgAssets.casesTime),
                                        onPressed: () async {
                                          selectDate(context,
                                              controller.timeController);
                                        },
                                      ),
                                      textController: controller.timeController,
                                    ),
                                    AddTextFieldWidget(
                                      width: width,
                                      labelText: 'Location',
                                      hintText: 'Location',
                                      textController:
                                          controller.locationController,
                                    ),
                                    AddTextFieldWidget(
                                      width: width,
                                      labelText: 'Title',
                                      hintText: 'Title',
                                      textController:
                                          controller.titleController,
                                    ),
                                    AddTextFieldWidget(
                                      width: width,
                                      labelText: 'Description',
                                      hintText: 'Description',
                                      textController:
                                          controller.descriptController,
                                    ),
                                    AddTextFieldWidget(
                                      width: width,
                                      labelText: 'Documents',
                                      hintText: 'Upload Documents',
                                      textController:
                                          controller.uploadController,
                                    ),
                                  ],
                                ),
                                15.height,
                                columnText('Contact Person Details', 18)
                                    .paddingOnly(left: 5),
                                10.height,
                                Obx(
                                  () => Wrap(
                                    spacing: Responsive.isDesktop(context)
                                        ? 2.5.w
                                        : 2.w,
                                    runSpacing: Responsive.isDesktop(context)
                                        ? 2.w
                                        : 1.8.w,
                                    children: [
                                      AddTextFieldWidget(
                                        width: width,
                                        labelText: 'Name',
                                        hintText: 'Name',
                                        textController:
                                            controller.persons[0].name,
                                      ),
                                      AddTextFieldWidget(
                                        width: width,
                                        labelText: 'Mobile',
                                        hintText: 'Mobile',
                                        textController:
                                            controller.persons[0].mobile,
                                      ),
                                      AddTextFieldWidget(
                                        width: width,
                                        labelText: 'Designation',
                                        hintText: 'Designation',
                                        textController:
                                            controller.persons[0].designation,
                                      ),
                                      // Display additional contact person fields if added
                                      for (var i = 1;
                                          i < controller.persons.length;
                                          i++)
                                        Wrap(
                                          spacing: Responsive.isDesktop(context)
                                              ? 2.5.w
                                              : 2.w,
                                          runSpacing:
                                              Responsive.isDesktop(context)
                                                  ? 2.w
                                                  : 1.8.w,
                                          children: [
                                            AddTextFieldWidget(
                                              width: width,
                                              labelText: 'Name',
                                              hintText: 'Name',
                                              textController:
                                                  controller.persons[i].name,
                                            ),
                                            AddTextFieldWidget(
                                              width: width,
                                              labelText: 'Mobile',
                                              hintText: 'Mobile',
                                              textController:
                                                  controller.persons[i].mobile,
                                            ),
                                            AddTextFieldWidget(
                                              width: width,
                                              labelText: 'Designation',
                                              hintText: 'Designation',
                                              textController: controller
                                                  .persons[i].designation,
                                            ),
                                          ],
                                        ),
                                      // Add More Person button
                                      SizedBox(
                                          width: width,
                                          height: 45,
                                          child: CommonOutlinedButton(
                                              lable: '+ ADD MORE PERSON',
                                              act: //controller.addPersons,
                                                  () {})),
                                    ],
                                  ),
                                ),
                                20.height,
                                Obx(() => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CheckBoxButton(
                                                selectItem:
                                                    controller.isReminder.value,
                                                act: () {
                                                  controller.isReminder.value =
                                                      !controller
                                                          .isReminder.value;
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
                                                textController: controller
                                                    .reminderDateController,
                                              )
                                            : const SizedBox(),
                                      ],
                                    ).paddingOnly(left: 5)),
                                15.height,
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: CommonButton(
                                        width: width,
                                        onClick: () {},
                                        label: 'ADD'))
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
