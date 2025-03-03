import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:sizer/sizer.dart';

class UpcomingContainer extends StatelessWidget {
  final String count;
  final String label;
  const UpcomingContainer(
      {super.key, required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(61, 66, 223, 0.2),
          border: Border.all(color: AppColor.primary),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          columnText(label, 11.sp),
          8.height,
          boldText(count, color: AppColor.primary, fontSize: 15.sp)
        ],
      ),
    );
  }
}
