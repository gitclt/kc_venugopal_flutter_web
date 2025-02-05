import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';


class HomeAppBar extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Function? onClick;
  final String? label;
  final bool? visible;
  final String? subTitle;
  const HomeAppBar(
      {super.key,
      required this.title,
      this.width,
      this.height,
      this.onClick,
      this.label,
      this.visible = true,
      this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.075,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Shadow color
            offset: const Offset(0, 0), // X, Y position
            blurRadius: 20, // Blur radius
            spreadRadius: 0, // Spread radius
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 8,
            height: MediaQuery.of(context).size.height * 0.04,
            color: AppColor.primary,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              if (subTitle != null)
                const SizedBox(
                  height: 3,
                ),
              if (subTitle != null)
                Text(subTitle!,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
            ],
          ),
          const Spacer(),
          if (onClick != null)
            SizedBox(
              // width: width ?? MediaQuery.of(context).size.width * 0.068,
              height: height ?? MediaQuery.of(context).size.height * 0.048,
              child: CommonButton(
                onClick: () {
                  onClick!();
                },
                label: label!,
                fontSize: 12,
              ),
            )
        ],
      ).paddingOnly(right: 15),
    ).marginOnly(bottom: 15);
  }
}
