import 'package:flutter/material.dart';

import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

class WrapContainer extends StatelessWidget {
  final Color? color;
  final String count;
  final String label;
  final String? badgeCount;
  final Function onTap;

  const WrapContainer({
    super.key,
    this.color,
    required this.count,
    required this.label,
    this.badgeCount, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Stack(
        clipBehavior: Clip.none, // Allows the badge to overflow
        children: [
          Container(
            width: Responsive.isDesktop(context)
                ? 10.w
                : Responsive.isMobile(context)
                    ? 20.w
                    : 10.w, // Adjust width as needed
            height: 15.h,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: color ?? Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  boldText(
                    count,
                    fontSize: 20.sp,
                  ),
                  // const SizedBox(height: 8),
                  columnText(label, 11.sp),
                ],
              ),
            ),
          ),

          // Positioned Badge
          if (badgeCount != null)
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.notifications,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      badgeCount!,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
