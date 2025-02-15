import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';

class CaseListWidget extends StatelessWidget {
  final Color lineColor;
  final Color? statusColor;
  final String title;
  final String issue;
  final String? description;
  final String? person;
  final String? mobile;
  final String? date;
  final String? status;
  const CaseListWidget(
      {super.key,
      required this.lineColor,
      required this.title,
      required this.issue,
      this.description,
      this.person,
      this.mobile,
      this.date,
      this.status,
      this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 4,
            height: MediaQuery.of(context).size.height * 0.09,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: lineColor),
          ),
          10.width,
          Expanded(
            // Added this Expanded
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        boldText(title, fontSize: 16),
                        10.width,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ColoredBox(
                            color: Color.fromRGBO(61, 66, 223, 0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: columnText(issue, 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (date != null)
                      Row(
                        children: [
                          Icon(Icons.date_range_outlined),
                          3.width,
                          columnText(formatDateString(date!), 14)
                        ],
                      )
                  ],
                ),
                5.height,
                if (description != null) columnText(description!, 14),
                5.height,
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Added this
                  children: [
                    Row(
                      children: [
                        if (person != null)
                          Row(
                            children: [
                              svgWidget('assets/svg/user.svg'),
                              columnText(person!, 14)
                            ],
                          ),
                        if (mobile != null)
                          Row(
                            children: [
                              10.width,
                              svgWidget('assets/svg/phone.svg'),
                              columnText(mobile!, 14)
                            ],
                          ),
                      ],
                    ),
                    if (status != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: ColoredBox(
                          color: statusColor!,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: columnText(status!, 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 8);
  }
}
