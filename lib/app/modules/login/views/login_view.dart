import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/login_textfield.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .5,
          height: double.infinity,
          color: AppColor.primary,
        ),
        Align(
          alignment: Alignment.center,
          child: Form(
            key: controller.formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: Responsive.isDesktop(context)
                      ? size.width * 0.35
                      : size.width * 0.7,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                              0x1A000000), // #000000 with 10% opacity (0x1A)
                          blurRadius: 50.0, // 50px blur radius
                          spreadRadius: 0.0, // No spread
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      shape: BoxShape.rectangle),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'login'.tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 40,
                              color: AppColor.primary),
                        ),
                        10.height,
                        LoginTextField(
                          hint: '',
                          label: 'user_name'.tr,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter user name';
                            }
                            return null;
                          },
                          textEditingController:
                              controller.emailController.value,
                        ).paddingSymmetric(vertical: 12),
                        const SizedBox(height: 12),
                        Obx(() => LoginTextField(
                              hint: '',
                              label: 'password'.tr,
                              obscureText: !controller.isVisiblePassword.value,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isVisiblePassword.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: AppColor.primary,
                                ),
                                onPressed: () {
                                  controller.isVisiblePassword(
                                      !controller.isVisiblePassword.value);
                                },
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter password';
                                }
                                return null;
                              },
                              textEditingController:
                                  controller.passwordController.value,
                            )).paddingSymmetric(vertical: 12),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     Obx(() => Checkbox(
                        //         value: controller.rememberMe.value,
                        //         onChanged: (value) {
                        //           controller.rememberMe.value =
                        //               value ?? false;
                        //         })),
                        //     Text(
                        //       'remember_me'.tr,
                        //       style: const TextStyle(
                        //         fontWeight: FontWeight.w700,
                        //         fontSize: 16,
                        //       ),
                        //     ).paddingOnly(right: 20),
                        //   ],
                        // ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => Tooltip(
                            message: "Click to login",
                            child: CommonButton(
                              isLoading: controller.isLoading.value,
                              onClick: () {
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  controller.login();
                                }
                              },
                              label: 'login'.tr,
                            ).paddingSymmetric(vertical: 10),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
