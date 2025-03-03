import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/check_box_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/case_detail_widgets/detail_document_section.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/timeline_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/launch_url.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/sidemenu_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/support_request/controllers/support_request_controller.dart';
import 'package:sizer/sizer.dart';

class CaseDetailWidget extends GetView<SupportRequestController> {
  final BoxConstraints cons;
  const CaseDetailWidget(this.cons, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                columnText(controller.dataDetail.first.title ?? '', 24),
                10.width,
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ColoredBox(
                    color: Color.fromRGBO(61, 66, 223, 0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: columnText(
                          controller.dataDetail.first.category ?? '', 12),
                    ),
                  ),
                ),
              ],
            ),
            15.height,
            columnHeaderText(controller.dataDetail.first.description ?? ''),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    columnHeaderText('Priority : '),
                    3.width,
                    boldText(
                        capitalizeLetter(
                            controller.dataDetail.first.priority ?? ''),
                        fontSize: 11.sp,
                        color: priorityColor(
                          controller.dataDetail.first.priority!,
                        ))
                  ],
                ),
                if (controller.dataDetail.first.contactPerson!.isNotEmpty)
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.account_circle_outlined),
                          3.width,
                          columnHeaderText(controller.dataDetail.first
                                  .contactPerson!.first.contactPerson ??
                              '')
                        ],
                      ),
                      10.width,
                      Row(
                        children: [
                          Icon(Icons.phone_outlined),
                          3.width,
                          columnHeaderText(controller.dataDetail.first
                                  .contactPerson!.first.mobile ??
                              '')
                        ],
                      ),
                    ],
                  )
              ],
            ),
            8.height,
            divider(),
            10.height,
            Flexible(
                child: DetailDocumentSection(
              data: controller.detailDocument,
              mediaPicker: (ImageSource? value, type) {
                controller.pickImage(value, type!, 'add document');
                Get.back();
              },
              onTap: (int index) {
                openFile(controller.detailDocument[index].documentPath ?? '');
              },
            )),
            12.height,
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: SimpleContainer(
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
                                        selectItem: controller.isReminder.value,
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
                                        selectDate(context,
                                            controller.reminderDateController);
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
                                        // pickImage: (ImageSource? value) {
                                        //   if (value != null) {
                                        //     controller.pickImage(
                                        //         value, 'detailCase');
                                        //     Get.back();
                                        //   }
                                        pickMedia: (ImageSource? value, type) {
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
    );
  }
}
