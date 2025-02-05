import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SimpleContainer(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  columnText("Today's Activities", 24),
                                  InkWell(
                                    onTap: () {},
                                    child: SimpleContainer(
                                        child: Text('VIEW ALL')),
                                  )
                                ],
                              ),
                              Wrap(
                                spacing: Responsive.isDesktop(context)
                                    ? 0.05.w
                                    : Responsive.isMobile(context)
                                        ? 10
                                        : 20,
                                runSpacing: 12,
                                children: [
                                  SimpleContainer(child: Text("program"))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SimpleContainer(child: Text("program")),
                      ],
                    ),
                  ),
                  10.width,
                  Expanded(
                    flex: 2,
                    child: SimpleContainer(
                      child: TableCalendar(
                        focusedDay: focusedDay,
                        firstDay: DateTime(2000),
                        lastDay: DateTime(2100),
                        selectedDayPredicate: (day) =>
                            isSameDay(selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          // setState(() {
                          //   _selectedDay = selectedDay;
                          //   _focusedDay = focusedDay;
                          // });
                        },
                        calendarFormat: CalendarFormat.month,
                        headerStyle: HeaderStyle(formatButtonVisible: false),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
