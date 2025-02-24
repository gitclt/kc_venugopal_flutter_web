import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_controller.dart';
import 'package:kc_venugopal_flutter_web/app/modules/reminder/controllers/reminder_controller.dart';

class ContactPersonView extends StatelessWidget {
  final ReminderController? reminderController;
  final ProgramScheduleController? programController;
  final String page;
  const ContactPersonView({super.key,this.reminderController, this.programController, required this.page, });

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
              textController: page == 'Programs' ? programController!.nameController :  reminderController!.nameController,
            ),
            12.height,
            AddTextFieldWidget(
              labelText: 'Mobile',
              hintText: 'Mobile',
              textController: page == 'Programs' ? programController!.mobileController :  reminderController!.mobileController,
              inputFormat: true,
              maxLengthLimit: 10,
            ),
            12.height,
            AddTextFieldWidget(
              labelText: 'Designation',
              hintText: 'Designation',
              textController:  page == 'Programs' ? programController!.desigController :  reminderController!.desigController,
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
                page == 'Programs'
                ? programController!.addMoreContactPerson(
                  programController!.nameController.text,
                  programController!.mobileController.text,
                  programController!.desigController.text,
                )
                :
                reminderController!.addMoreContactPerson(
                  reminderController!.nameController.text,
                  reminderController!.mobileController.text,
                  reminderController!.desigController.text,
                )
                 ;
                Get.back();
              },
              child: Text("ADD"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   // var width = MediaQuery.of(context).size.width * 0.37;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
       
        10.height,
        Flexible(
          child: Obx(() => (page == 'Programs' ? programController!.contactPersons.isNotEmpty : reminderController!.contactPersons.isNotEmpty)
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
                    if(page == 'Programs')
                    ...programController!.contactPersons.map((person) => TableRow(
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
                        ))
                      else
                       ...reminderController!.contactPersons.map((person) => TableRow(
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
            width: double.infinity,
            height: 45,
            child: CommonOutlinedButton(
              lable: (page == 'Programs' ? programController!.contactPersons.isEmpty : reminderController!.contactPersons.isEmpty)
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
