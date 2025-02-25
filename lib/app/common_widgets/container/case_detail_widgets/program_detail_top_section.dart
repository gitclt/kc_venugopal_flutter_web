import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/svg_icons/svg_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:sizer/sizer.dart';

class ProgramDetailTopSection extends StatelessWidget {
  final String title;
  final String category;
  final String description;
  final String? location;
  final String priority;
  final String contactPerson;
  final String mobile;
  const ProgramDetailTopSection(
      {super.key,
      required this.title,
      required this.category,
      required this.description,
      this.location,
      required this.priority,
      required this.contactPerson,
      required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            columnText(title, 24),
            10.width,
            if (category != '')
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ColoredBox(
                  color: Color.fromRGBO(61, 66, 223, 0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: columnText(category, 12),
                  ),
                ),
              ),
          ],
        ),
        10.height,
        if (description != '') columnHeaderText(description),
        10.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                if (location != '')
                  Row(
                    children: [
                      svgWidget(SvgAssets.caseLocation, size: 20),
                      3.width,
                      columnText(
                        capitalizeLetter(location!),
                        11.sp,
                      )
                    ],
                  ),
                10.width,
                if (priority != '')
                  Row(
                    children: [
                      columnHeaderText('Priority : '),
                      3.width,
                      boldText(capitalizeLetter(priority),
                          fontSize: 11.sp,
                          color: priorityColor(
                            priority,
                          ))
                    ],
                  ),
              ],
            ),
            if (contactPerson != '')
              Row(
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle_outlined),
                      3.width,
                      columnHeaderText(contactPerson)
                    ],
                  ),
                  10.width,
                  if (mobile != '')
                    Row(
                      children: [
                        Icon(Icons.phone_outlined),
                        3.width,
                        columnHeaderText(mobile)
                      ],
                    ),
                ],
              )
          ],
        ),
      ],
    );
  }
}
