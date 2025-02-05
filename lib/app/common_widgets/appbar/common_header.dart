import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final String? subTitle;
  final String? label;

  const CommonHeader({
    super.key,
    required this.title,
    this.width,
    this.height,
    this.label,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
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
                  fontWeight: FontWeight.w400)),
      ],
    ).paddingOnly(right: 15);
  }
}
