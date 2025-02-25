import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/check_box_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/case_detail_widgets/detail_document_section.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/case_detail_widgets/program_detail_top_section.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/timeline_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/launch_url.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/sidemenu_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/reminder/controllers/reminder_controller.dart';

class ReminderDetailWidget extends GetView<ReminderController> {
  final BoxConstraints cons;
  const ReminderDetailWidget({super.key, required this.cons});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: cons.maxHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgramDetailTopSection(
                  title: controller.dataDetail.first.title ?? '',
                  category: controller.dataDetail.first.category ?? '',
                  description: controller.dataDetail.first.description ?? '',
                  priority: controller.dataDetail.first.priority ?? '',
                  contactPerson: controller.dataDetail.first.contactPerson!
                          .first.contactPerson ??
                      '',
                  mobile:
                      controller.dataDetail.first.contactPerson!.first.mobile ??
                          ''),
              8.height,
              divider(),
              8.height,
              Flexible(
                child: DetailDocumentSection(
                  data: controller.detailDocument,
                  mediaPicker: (ImageSource? value, type) {
                    controller.pickImage(value, type!, 'add document');
                    Get.back();
                  },
                  onTap: (int index) {
                    openFile(
                        controller.detailDocument[index].documentPath ?? '');
                  },
                ),
              ),
              12.height,
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: SimpleContainer(
                        child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          boldText('Change Status'),
                          10.height,
                          AddTextFieldWidget(
                            width: double.infinity,
                            labelText: 'Activity',
                            hintText: 'Type activity here',
                            minLines: 2,
                            textController: controller.activityController,
                          ),
                          12.height,
                          DropDown3Widget(
                            width: double.infinity,
                            hint: '--Select Status--',
                            selectedItem: controller.detailStatusDrop.id == null
                                ? null
                                : controller.detailStatusDrop,
                            items: controller.statusDropList
                                .where((e) => e.id != '')
                                .toList(),
                            onChanged: (data) async {
                              if (data == null) return;
                              controller.detailStatusDrop = data;
                            },
                          ),
                          12.height,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SimpleContainer(
                                child: Obx(() => Row(
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
                                    )),
                              ),
                              12.width,
                              Obx(() => controller.isReminder.value
                                  ? Expanded(
                                      child: AddTextFieldWidget(
                                        //  width: cons.minWidth,
                                        labelText: 'Date',
                                        hintText: 'YYYY-MM-DD',
                                        textController:
                                            controller.reminderDateController,
                                        suffixIcon: IconButton(
                                          icon: const Icon(
                                              Icons.calendar_today_outlined,
                                              size: 20),
                                          onPressed: () async {
                                            selectDate(
                                                context,
                                                controller
                                                    .reminderDateController);
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox()),
                              12.width,
                              Expanded(
                                child: AddTextFieldWidget(
                                  // width: cons.minWidth * 0.2,
                                  labelText: 'Upload Documents',
                                  hintText: 'Upload Documents',
                                  readonly: true,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        Get.bottomSheet(
                                          PickImageBottomsheet(
                                            pickMedia: (ImageSource? value,
                                                String? type) {
                                              controller.pickImage(
                                                  value, type!, 'detailCase');
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
                                  textController:
                                      controller.remindDocumentController,
                                ),
                              ),
                            ],
                          ),
                          12.height,
                          Obx(
                            () => CommonButton(
                                isLoading: controller.isStatusLoading.value,
                                onClick: () {
                                  controller.updateStatus();
                                },
                                label: 'CHANGE STATUS'),
                          )
                        ],
                      ),
                    )),
                  ),
                  16.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      boldText('Status', fontSize: 20),
                      if (controller.detailStatus.isNotEmpty)
                        Flexible(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.detailStatus.length,
                              itemBuilder: (context, index) {
                                final item = controller.detailStatus[index];
                                return TimelineWidget(
                                  date: item.date ?? '',
                                  status: item.status ?? '',
                                  index: index,
                                  length: controller.detailStatus.length,
                                );
                              },
                            ),
                          ),
                        )
                    ],
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
