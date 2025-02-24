import 'package:flutter/material.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineWidget extends StatelessWidget {
  final String status;
  final int index;
  final int length;
  const TimelineWidget(
      {super.key,
      required this.status,
      required this.index,
      required this.length});

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
          padding: const EdgeInsets.all(5.0),
          child: Text(capitalizeLetter(status)),
        ),
      ),
    );
  }
}
