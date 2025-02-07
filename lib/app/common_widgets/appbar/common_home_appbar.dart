import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:sizer/sizer.dart';

class HomeAppBar extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Function? onClick;
  // final String? label;
  final bool? visible;
  final String? subTitle;
  final bool isAdd;
  const HomeAppBar(
      {super.key,
      required this.title,
      this.width,
      this.height,
      this.onClick,
      // this.label,
      this.visible = true,
      this.isAdd = false,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            columnText(title, 14.sp),
          ],
        ),
        const Spacer(),
        if (subTitle != null)
          const SizedBox(
            height: 8,
          ),
        if (subTitle != null) subTitleText(subTitle!),
        if (onClick != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            height: height ?? MediaQuery.of(context).size.height * 0.048,
            decoration: BoxDecoration(
                border: Border.all(color: AppColor.primary),
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
              onPressed: () {
                onClick!();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isAdd)
                    Icon(
                      Icons.add_circle_outline,
                      color: AppColor.primary,
                      size: 20,
                    ),
                  if (isAdd)
                    const SizedBox(
                      width: 5,
                    ),
                  boldText(isAdd ? 'ADD NEW' : 'VIEW ALL',
                      fontSize: 12, color: AppColor.primary)
                ],
              ),
            ),
          )
      ],
    ).paddingOnly(right: 15).marginOnly(bottom: 15);
  }
}
