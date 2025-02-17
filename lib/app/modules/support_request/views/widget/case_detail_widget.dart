import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/check_box_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/timeline_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/sidemenu_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/support_request/controllers/support_request_controller.dart';
import 'package:sizer/sizer.dart';

class CaseDetailWidget extends GetView<SupportRequestController> {
  final BoxConstraints cons;
  const CaseDetailWidget(this.cons, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: cons.minHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
                        color: controller.priorityColor(
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
            10.height,
            divider(),
            10.height,
            SimpleContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                columnText('Documents', 22),
                if (controller.detailDocument.isNotEmpty)
                  Flexible(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // 4 columns as per your image
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio:
                            2 / 1, // Adjust the width-to-height ratio
                      ),
                      itemCount: controller.detailDocument.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: controller
                                      .detailDocument[index].documentPath ??
                                  '',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.insert_drive_file, size: 30),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                12.height,
                CommonButton(onClick: () {}, label: '+ Add New Document')
              ],
            )),
            15.height,
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        items: controller.statusDropList,
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
                                    hintText: 'DD/MM/YYYY',
                                    textController:
                                        controller.reminderDateController,
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
                                        pickImage: (ImageSource? value) {
                                          if (value != null) {
                                            controller.pickImage(
                                                value, 'detailCase');
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boldText('Status', fontSize: 20),
                    if (controller.detailStatus.isNotEmpty)
                      Flexible(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.detailStatus.length,
                            itemBuilder: (context, index) {
                              final item = controller.detailStatus[index];
                              return TimelineWidget(
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
