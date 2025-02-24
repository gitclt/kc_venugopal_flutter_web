import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/bottomsheet/pick_image_bottomsheet.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/timeline_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/sidemenu_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_controller.dart';
import 'package:sizer/sizer.dart';

class ProgramDetailWidget extends GetView<ProgramScheduleController> {
  final BoxConstraints cons;
  const ProgramDetailWidget({super.key, required this.cons});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          svgWidget(SvgAssets.caseLocation, size: 20),
                          3.width,
                          columnText(
                            capitalizeLetter(
                                controller.dataDetail.first.location ?? ''),
                            11.sp,
                          )
                        ],
                      ),
                      10.width,
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
              Expanded(
                child: SimpleContainer(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    columnText('Documents', 22),
                    if (controller.detailDocument.isNotEmpty)
                      GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, // 4 columns as per your image
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          mainAxisExtent: 130,
                          childAspectRatio:
                              1, // Adjust the width-to-height ratio
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
                                    Icon(Icons.insert_drive_file, size: 20),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                              ),
                            ),
                          );
                        },
                      ).paddingOnly(top: 10),
                    12.height,
                    CommonButton(
                        onClick: () {
                          Get.bottomSheet(
                            PickImageBottomsheet(
                              pickImage: (ImageSource? value) {
                                if (value != null) {
                                  controller.pickImage(value, 'add document');
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
                        label: '+ Add New Document')
                  ],
                )),
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
                          AddTextFieldWidget(
                            width: double.infinity,
                            labelText: 'Remark',
                            hintText: 'Remark',
                            minLines: 2,
                            textController: controller.remarkController,
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
