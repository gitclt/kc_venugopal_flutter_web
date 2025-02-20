import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/reminder/controllers/reminder_controller.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class ContactPersonView extends GetView<ReminderController> {
  const ContactPersonView({super.key});

  void _showAddPersonDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Add Contact Person"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddTextFieldWidget(
              labelText: 'Name',
              hintText: 'Name',
              textController: controller.nameController,
            ),
            12.height,
            AddTextFieldWidget(
              labelText: 'Mobile',
              hintText: 'Mobile',
              textController: controller.mobileController,
              inputFormat: true,
              maxLengthLimit: 10,
            ),
            12.height,
            AddTextFieldWidget(
              labelText: 'Designation',
              hintText: 'Designation',
              textController: controller.desigController,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("CANCEL"),
          ),
          TextButton(
              onPressed: () {
                controller.addMoreContactPerson(
                  controller.nameController.text,
                  controller.mobileController.text,
                  controller.desigController.text,
                );
                Get.back();
              },
              child: Text("ADD"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.37;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Flexible(
        //   child: Wrap(
        //     spacing: Responsive.isDesktop(context) ? 2.5.w : 2.w,
        //     runSpacing: Responsive.isDesktop(context) ? 2.w : 1.8.w,
        //     children: [
        //       AddTextFieldWidget(
        //         width: width,
        //         labelText: 'Name',
        //         hintText: 'Name',
        //         textController: controller.nameController,
        //       ),
        //       12.height,
        //       AddTextFieldWidget(
        //         width: width,
        //         labelText: 'Mobile',
        //         hintText: 'Mobile',
        //         textController: controller.mobileController,
        //       ),
        //         12.height,
        //       AddTextFieldWidget(
        //         width: width,
        //         labelText: 'Designation',
        //         hintText: 'Designation',
        //         textController: controller.desigController,
        //       ),
        //     ],
        //   ),
        // ),
        10.height,
        Flexible(
          child: Obx(() => controller.contactPersons.isNotEmpty
              ? Table(
                  border: TableBorder.all(),
                  columnWidths: {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Colors.grey[300]),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Name",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Mobile",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Designation",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    ...controller.contactPersons.map((person) => TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(person["name"]!),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(person["mobile"]!),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(person["designation"]!),
                            ),
                          ],
                        )),
                  ],
                )
              : const SizedBox()),
        ),
        10.height,
        Obx(
          () => SizedBox(
            // width: MediaQuery.of(context).size.width * 0.3,
            height: 45,
            child: CommonOutlinedButton(
              lable: controller.contactPersons.isEmpty
                  ? '+ ADD CONTACT PERSON'
                  : '+ ADD MORE PERSON',
              act: () => _showAddPersonDialog(context),
            ),
          ),
        ),
      ],
    );
  }
}
