import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/core/globals/date_time_formating.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineWidget extends StatelessWidget {
  final String status;
  final int index;
  final int length;
  final String? date;
  const TimelineWidget(
      {super.key,
      required this.status,
      required this.index,
      required this.length,
      this.date});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.2,
        isFirst: index == 0,
        isLast: index == length - 1,
        beforeLineStyle: LineStyle(
            color: index == 0 ? Colors.black : Colors.green, thickness: 1.5),
        // afterLineStyle: LineStyle(
        //   // Add this to control the line after the indicator
        //   color: Colors.green,
        //   thickness: 1.5,
        // ),
        indicatorStyle: IndicatorStyle(
          width: 22,
          height: 22,
          indicator: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
        endChild: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              columnText(capitalizeLetter(status), 12),
              5.height,
              if (date != '') columnText(formatDateString(date!), 10)
            ],
          ),
        ),
      ),
    );
  }
}
