import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';

import 'package:flutter/material.dart';

class SimpleContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
   final double? horizontal;
  final double? vertical;
  const SimpleContainer({super.key, required this.child, this.color,
      this.horizontal = 12,
      this.vertical = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(
          horizontal: horizontal ?? 12, vertical: vertical ?? 12),
      decoration: BoxDecoration(
          border: Border.all(color: color ?? AppColor.boxBorderColor),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white),
      child: child,
    );
  }
}

class PageContainer extends StatelessWidget {
  final Widget child;

  const PageContainer({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
      child: child,
    );
  }
}
