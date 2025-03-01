import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/cards/status_card.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';
import 'package:sizer/sizer.dart';

class ProgramListWidget extends StatelessWidget {
  final Color? lineColor;
  final String? reminderType;
  final String title;
  final String issue;
  final String? description;
  final String? person;
  final String? mobile;
  final String? date;
  final String? time;
  final String? address;
  final String? status;
  final Function onTap;
  const ProgramListWidget(
      {super.key,
      this.lineColor,
      required this.title,
      required this.issue,
      this.description,
      this.person,
      this.mobile,
      this.date,
      this.status,
      this.time,
      this.address,
      this.reminderType,
      required this.onTap});

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.amber;
      case "completed":
        return Colors.green;
      case "processing":
        return Colors.blue;
      case "opened":
        return Colors.orange;
      case "request accepted":
        return Colors.lightGreen;
      case "support requested":
        return Colors.purple;
      case "attended":
        return Colors.cyan;
      case "action 1":
        return Colors.red;
      case "followup":
        return Colors.teal;
      case "closed":
        return Colors.grey;
      default:
        return Colors.black; // Default fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.borderColor),
            borderRadius: BorderRadius.circular(6)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (status != '')
              Container(
                width: 4,
                height: MediaQuery.of(context).size.height * 0.085,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: _getStatusColor(status!)),
              ),
            10.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          boldText(title, fontSize: 12.sp),
                          10.width,
                          if (reminderType != '' && reminderType != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: ColoredBox(
                                color: Color.fromRGBO(61, 66, 223, 0.1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: columnText(
                                      capitalizeLetter(reminderType!), 12,
                                      color: Color.fromRGBO(67, 24, 255, 1)),
                                ),
                              ),
                            ),
                          if (reminderType != '') 10.width,
                          if (issue != '')
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: ColoredBox(
                                color: Color.fromRGBO(61, 66, 223, 0.1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
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
                          if (time != '') 10.width,
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
                          12.width,
                          if (status != '')
                            StatusWidget(
                              status: capitalizeLetter(status!),
                            )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).paddingOnly(bottom: 8),
    );
  }
}
