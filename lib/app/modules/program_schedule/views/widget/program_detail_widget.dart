import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/case_detail_widgets/detail_document_section.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/case_detail_widgets/program_detail_top_section.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/timeline_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/launch_url.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/sidemenu_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_controller.dart';

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
              ProgramDetailTopSection(
                title: controller.dataDetail.first.title ?? '',
                category: controller.dataDetail.first.category ?? '',
                description: controller.dataDetail.first.description ?? '',
                location: controller.dataDetail.first.location ?? '',
                priority: controller.dataDetail.first.priority ?? '',
                contactPerson:
                    controller.dataDetail.first.contactPerson!.isNotEmpty
                        ? controller.dataDetail.first.contactPerson!.first
                            .contactPerson!
                        : '',
                mobile: controller.dataDetail.first.contactPerson!.isNotEmpty
                    ? controller.dataDetail.first.contactPerson!.first.mobile!
                    : '',
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
                    openFile(
                        controller.detailDocument[index].documentPath ?? '');
                  },
                ),
              ),
              // Flexible(
              //   child: SimpleContainer(
              //       child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       columnText('Documents', 22),
              //       if (controller.detailDocument.isNotEmpty)
              //         GridView.builder(
              //           shrinkWrap: true,
              //           physics: AlwaysScrollableScrollPhysics(),
              //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //             crossAxisCount: 5, // 4 columns as per your image
              //             crossAxisSpacing: 8,
              //             mainAxisSpacing: 8,
              //             mainAxisExtent: 130,
              //             childAspectRatio:
              //                 1, // Adjust the width-to-height ratio
              //           ),
              //           itemCount: controller.detailDocument.length,
              //           itemBuilder: (context, index) {
              //             return Container(
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Colors.grey.shade300),
              //                 borderRadius: BorderRadius.circular(8),
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.center,
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   CachedNetworkImage(
              //                     imageUrl: controller
              //                             .detailDocument[index].documentPath ??
              //                         '',
              //                     width: 60,
              //                     height: 60,
              //                     fit: BoxFit.contain,
              //                     errorWidget: (context, url, error) => Icon(
              //                       Icons.insert_drive_file,
              //                       size: 22,
              //                       color: AppColor.appointTextColor,
              //                     ),
              //                     // placeholder: (context, url) =>
              //                     //     CircularProgressIndicator(),
              //                   ),
              //                   5.height,
              //                   columnText(
              //                       Uri.parse(controller.detailDocument[index]
              //                                   .documentPath ??
              //                               '')
              //                           .pathSegments
              //                           .last,
              //                       10)
              //                 ],
              //               ),
              //             );
              //           },
              //         ).paddingOnly(top: 10),
              //       12.height,
              //       CommonButton(
              //           onClick: () {
              //             Get.bottomSheet(
              //               PickImageBottomsheet(
              //                 pickImage: (ImageSource? value) {
              //                   if (value != null) {}
              //                 },
              //               ),
              //               elevation: 20.0,
              //               enableDrag: false,
              //               isDismissible: true,
              //               backgroundColor: Colors.white,
              //               shape: bootomSheetShape(),
              //             );
              //           },
              //           label: '+ Add New Document')
              //     ],
              //   )),
              // ),
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
