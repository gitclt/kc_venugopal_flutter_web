import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_header.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/wrap_container.dart';
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: ResponsiveWidget(
            mobile: (context) => _buildMobileLayout(context, size),
            desktop: (context) => _buildDesktopLayout(context, size),
          ),
        ),
      ),
    );
  }

  /// **Mobile Layout**
  Widget _buildMobileLayout(BuildContext context, Size size) {
    return Column(
      children: [
        _buildActivities(size, context),
        SizedBox(height: 20),
        _buildCalendar(size),
      ],
    );
  }

  /// **Desktop Layout**
  Widget _buildDesktopLayout(BuildContext context, Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonHeader(
          title: "Dashboard",
          subTitle: "Home / Dashboard",
        ),
        20.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 3, child: _buildActivities(size, context)),
            SizedBox(width: 10),
            Expanded(flex: 2, child: _buildCalendar(size)),
          ],
        ),
      ],
    );
  }

  /// **Activities Section**
  Widget _buildActivities(Size size, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SimpleContainer(
          // Use Responsive logic here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  columnText("Today's Activities", 15.sp),
                  InkWell(
                    onTap: () {},
                    child: SimpleContainer(
                        horizontal: 10,
                        vertical: 5,
                        color: AppColor.primary,
                        child: Text(
                          'VIEW ALL',
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColor.primary,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ],
              ),
              20.height,
              Wrap(
                spacing: Responsive.isDesktop(context)
                    ? 1.8.w
                    : 2.w, // Horizontal spacing
                runSpacing: 15, // Vertical spacing
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  WrapContainer(
                    count: '10',
                    label: 'Support Requests',
                    badgeCount: '05',
                  ),
                  WrapContainer(
                      count: '08', label: 'Program Schedule', badgeCount: '05'),
                  WrapContainer(
                      count: '00', label: 'Wedding', badgeCount: '05'),
                  WrapContainer(count: '00', label: 'Death', badgeCount: '05')
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Column(children: [columnText("Upcoming Activities", 24)]),
      ],
    );
  }

  /// **Calendar Section**
  Widget _buildCalendar(Size size) {
    return SimpleContainer(
      // Adjust based on screen size
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2000),
        lastDay: DateTime(2100),
        selectedDayPredicate: (day) => false,
        onDaySelected: (selectedDay, focusedDay) {},
        calendarFormat: CalendarFormat.month,
        headerStyle: HeaderStyle(formatButtonVisible: false),
      ),
    );
  }
}
