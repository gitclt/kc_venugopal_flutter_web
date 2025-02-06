
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static dateConvert(String? date) {
    if (date == null) return;

    DateFormat format = DateFormat("dd-MM-yyyy");
    DateTime dateTime = format.parse(date);
    return dateTime;
  }

  String getFormattedTimestamp() {
    final now = DateTime.now();
    final formatted = now.millisecondsSinceEpoch.toString();
    return formatted;
  }
//   static snackBar(
//     String title,
//     String message,
//   ) {
//     Get.snackbar(
//       title,
//       message,
//       backgroundColor: AppColor.white,
//       snackPosition: SnackPosition.TOP,
//       maxWidth: GetPlatform.isDesktop ? Get.width * .5 : null,
//       colorText: AppColor.primary,
//     );
//   }
// }

  static snackBar(String title, String message, {String type = 'eroor'}) {
    type == 'eroor'
        ? Get.snackbar(
            title,
            message,
            icon: const Icon(Icons.error, color: Colors.white),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColor.primary,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            isDismissible: true,
            maxWidth: GetPlatform.isDesktop || GetPlatform.isWeb
                ? Get.width * .3
                : null,
            dismissDirection: DismissDirection.startToEnd,
            forwardAnimationCurve: Curves.easeOutBack,
          )
        : Get.snackbar(
            title,
            message,
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            borderRadius: 20,
            margin: const EdgeInsets.all(15),
            colorText: Colors.white,
            duration: const Duration(seconds: 4),
            isDismissible: true,
            maxWidth: GetPlatform.isDesktop || GetPlatform.isWeb
                ? Get.width * .3
                : null,
            dismissDirection: DismissDirection.startToEnd,
            forwardAnimationCurve: Curves.easeOutBack,
          );
  }
}
