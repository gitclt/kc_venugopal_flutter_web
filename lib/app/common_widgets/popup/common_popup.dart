import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';


// common dialog box
Future<dynamic> commonDialog(
    {required String title,
    required String subTitle,
    String? label,
    IconData? titleIcon,
    Color? theamColor}) {
  return Get.dialog(
    AlertDialog(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      title: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1E000000),
                  blurRadius: 12,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                )
              ],
            ),
            child: Center(
                child: Icon(
              titleIcon,
              color: theamColor ?? AppColor.primary,
            )),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      content: subTitle.isEmpty
          ? null
          : Text(
              subTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xff868186),
                fontSize: 14,
                height: 1.2,
              ),
            ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CommonButton(
                width: 100,
                label: 'No',
                onClick: () {
                  Get.back(result: false);
                },
              ),
              const SizedBox(
                width: 20,
              ),
              CommonButton(
                width: 100,
                label: label ?? 'Yes',
                onClick: () {
                  Get.back(result: true);
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
