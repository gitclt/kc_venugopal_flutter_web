import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';

class ProgramListWidget extends StatelessWidget {
  final Color lineColor;
  final Color? statusColor;
  final String title;
  final String issue;
  final String? description;
  final String? person;
  final String? mobile;
  final String? date;
  final String? time;
  final String? address;
  final String? status;
  const ProgramListWidget(
      {super.key,
      required this.lineColor,
      this.statusColor,
      required this.title,
      required this.issue,
      this.description,
      this.person,
      this.mobile,
      this.date,
      this.status,
      this.time,
      this.address});

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
                    Row(
                      children: [
                        if (date != '')
                          Row(
                            children: [
                              svgWidget(SvgAssets.casesDate),
                              3.width,
                              columnText(formatDateString(date!), 14)
                            ],
                          ),
                        if (time != '')
                          Row(
                            children: [
                              svgWidget(SvgAssets.casesTime),
                              3.width,
                              columnText(time!, 14)
                            ],
                          ),
                      ],
                    )
                  ],
                ),
                5.height,
                if (description != '') columnText(description!, 14),
                5.height,
                Row(
                  children: [
                    if (address != '')
                      Row(
                        children: [
                          svgWidget(SvgAssets.caseLocation),
                          3.width,
                          columnText(address!, 14)
                        ],
                      ),
                    Spacer(),
                    Row(
                      children: [
                        if (person != null)
                          Row(
                            children: [
                              svgWidget('assets/svg/user.svg'),
                              columnText(person!, 14)
                            ],
                          ),
                        5.width,
                        if (mobile != '')
                          Row(
                            children: [
                              10.width,
                              svgWidget('assets/svg/phone.svg'),
                              columnText(mobile!, 14)
                            ],
                          ),
                        5.width,
                        if (status != '')
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
              ],
            ),
          ),
        ],
      ),
    ).paddingOnly(bottom: 8);
  }
}
