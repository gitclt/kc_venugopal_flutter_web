import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/modules/cases/controllers/cases_controller.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:kc_venugopal_flutter_web/app/utils/utils.dart';
import 'package:sizer/sizer.dart';

class PersonalInfoTabView extends GetView<CasesController> {
  final BoxConstraints cons;
  const PersonalInfoTabView({super.key, required this.cons});

  @override
  Widget build(BuildContext context) {
    var width = cons.maxWidth * 0.45;
    return SimpleContainer(
        child: Form(
      key: controller.formkey,
      child: Wrap(
        spacing: Responsive.isDesktop(context) ? 2.5.w : 2.w,
        runSpacing: Responsive.isDesktop(context) ? 2.w : 1.8.w,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: [
          AddTextFieldWidget(
            width: width,
            labelText: 'Name',
            hintText: 'Name',
            textController: controller.nameController,
          ),
          AddTextFieldWidget(
            width: width,
            labelText: 'Address',
            hintText: 'Address',
            textController: controller.addressController,
          ),
          AddTextFieldWidget(
            width: width,
            labelText: 'E-mail',
            hintText: 'E-mail',
            textController: controller.emailController,
            validator: Validators.validateEmail,
          ),
          AddTextFieldWidget(
            width: width,
            labelText: 'Mobile No.',
            hintText: 'Mobile No.',
            inputFormat: true,
            maxLengthLimit: 10,
            textController: controller.mobileController,
            validator: (value) {
              if (value.isNotEmpty && value.length < 10) {
                return 'Please provide a valid Mobile Number';
              } else if (value.isEmpty) {
                return 'Please enter Mobile number';
              }
              return null;
            },
          ),
          AddTextFieldWidget(
            width: width,
            labelText: 'Location',
            hintText: 'Location',
            textController: controller.locationController,
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: CommonButton(
                  width: width,
                  onClick: () {
                    if (controller.formkey.currentState!.validate()) {
                      controller.tabController.animateTo(1);
                    }
                  },
                  label: 'NEXT'))
        ],
      ).paddingSymmetric(vertical: 15, horizontal: 10),
    ));
  }
}
