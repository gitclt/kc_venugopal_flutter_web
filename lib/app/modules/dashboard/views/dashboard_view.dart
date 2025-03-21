import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_header.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/upcoming_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/wrap_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/dashboard/views/widget/program_data_source.dart';
import 'package:kc_venugopal_flutter_web/app/modules/dashboard/views/widget/support_data_source.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
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
    return LayoutBuilder(builder: (context, s) {
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
              Expanded(flex: 1, child: _buildCalendar(size)),
            ],
          ),
          25.height,
          SizedBox(
            height: 300,
            child: SimpleContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    columnText("Program Schedules", 15.sp),
                    InkWell(
                      onTap: () {
                        Get.rootDelegate.toNamed(Routes.ALL_ACTIVITIES,
                            arguments: {"type": "program schedule"});
                      },
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
                12.height,
                Obx(() => controller.isRequestLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.programData.isEmpty
                        ? Center(
                            child: columnText('No Program Schedules', 11.sp),
                          )
                        : Expanded(
                            child: SfDataGrid(
                                columnWidthMode: ColumnWidthMode.fill,
                                gridLinesVisibility:
                                    GridLinesVisibility.horizontal,
                                isScrollbarAlwaysShown: true,
                                source: ProgramDataSource(
                                    dataList: controller.programData),
                                columns: _buildColumns()),
                          ))
              ],
            )),
          ),
          15.height,
          SizedBox(
            height: 350,
            child: SimpleContainer(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    columnText("Support Requests", 15.sp),
                    InkWell(
                      onTap: () {
                        Get.rootDelegate.toNamed(Routes.ALL_ACTIVITIES,
                            arguments: {"type": "support request"});
                      },
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
                12.height,
                Obx(() => controller.isRequestLoading.value
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.supportData.isEmpty
                        ? Center(
                            child: columnText('No Support Requests', 11.sp),
                          )
                        : Expanded(
                            child: SfDataGrid(
                                    columnWidthMode: ColumnWidthMode.fill,
                                    //  headerGridLinesVisibility: GridLinesVisibility.horizontal,
                                    gridLinesVisibility:
                                        GridLinesVisibility.horizontal,
                                    isScrollbarAlwaysShown: true,
                                    source: SupportDataSource(
                                        dataList: controller.supportData),
                                    columns: _buildColumns())
                                .paddingOnly(bottom: 20),
                          ))
              ],
            )),
          ),
        ],
      );
    });
  }

  List<GridColumn> _buildColumns(
      // double fontSize,
      ) {
    return [
      GridColumn(
        allowSorting: false,
        columnName: 'NAME',
        width: 90,
        label: Center(child: columnHeaderText('NAME')),
        // width: 80,
      ),
      GridColumn(
        columnName: 'DATE',
        allowSorting: false,
        label: Center(child: columnHeaderText('DATE')),
      ),
      GridColumn(
        allowSorting: false,
        columnName: 'CATEGORY',
        label: Center(child: columnHeaderText('CATEGORY')),
      ),
      GridColumn(
        columnName: 'PRIORITY',
        allowSorting: false,
        label: Center(child: columnHeaderText('PRIORITY')),
      ),
      GridColumn(
        columnName: 'CONTACT PERSON',
        allowSorting: false,
        label: Center(child: columnHeaderText('CONTACT PERSON')),
      ),
      GridColumn(
        columnName: 'STATUS',
        allowSorting: false,
        label: Center(child: columnHeaderText('STATUS')),
      ),
    ];
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
                    onTap: () {
                      Get.rootDelegate.toNamed(Routes.ALL_ACTIVITIES,
                          arguments: {
                            "type": controller.todaysData.first.type,
                            "timeRange": 'day'
                          });
                    },
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
              Obx(
                () => controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Wrap(
                        spacing: Responsive.isDesktop(context)
                            ? 1.8.w
                            : 2.w, // Horizontal spacing
                        runSpacing: 15, // Vertical spacing
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: controller.todaysData
                            .map((data) => WrapTodayContainer(
                                  count: data.count ?? '0',
                                  label: capitalizeLetter(data.type ?? ''),
                                  badgeCount: data.reminderCount ?? '0',
                                ))
                            .toList()),
              ),
            ],
          ),
        ),
        20.height,
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          columnText("Upcoming Activities", 15.sp),
          15.height,
          Obx(() => controller.isLoading.value
              ? CircularProgressIndicator()
              : controller.upcomingReminders.isEmpty
                  ? Center(child: Text('No Upcoming Activities'))
                  : Wrap(
                      spacing: Responsive.isDesktop(context)
                          ? 1.8.w
                          : 2.w, // Horizontal spacing
                      runSpacing: 15, // Vertical spacing
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: controller.upcomingReminders
                          .map((item) => UpcomingContainer(
                              count: item.count ?? '0',
                              label: capitalizeLetter(item.label ?? '')))
                          .toList())),
        ]),
      ],
    );
  }

  /// **Calendar Section**
  Widget _buildCalendar(Size size) {
    return Obx(
      () => controller.isLoading.value
          ? CircularProgressIndicator(
              color: Colors.white,
            )
          : GetBuilder<DashboardController>(builder: (_) {
              return SimpleContainer(
                child: TableCalendar(
                  focusedDay: DateTime.now(),
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  selectedDayPredicate: (day) => false,
                  onDaySelected: (selectedDay, focusedDay) {},
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(formatButtonVisible: false),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      String formattedDay = day
                          .toIso8601String()
                          .substring(0, 10); // Convert to "YYYY-MM-DD"

                      int index = controller.eventDates.indexOf(formattedDay);
                      bool isEventDay = index != -1;
                      String? eventType =
                          isEventDay ? controller.eventTypes[index] : null;
                      return Tooltip(
                        message: isEventDay ? eventType : '',
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: AppColor.primary),
                        textStyle: TextStyle(color: Colors.white),
                        child: InkWell(
                          onTap: () {
                            Get.rootDelegate.toNamed(Routes.ALL_ACTIVITIES,
                                arguments: {
                                  "date": formattedDay,
                                  "type": eventType
                                });
                          },
                          child: Container(
                            margin: EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isEventDay
                                  ? AppColor.primary
                                  : Colors.transparent,
                              shape: isEventDay
                                  ? BoxShape.circle
                                  : BoxShape.rectangle,
                            ),
                            child: Text(
                              '${day.day}',
                              style: TextStyle(
                                color: isEventDay
                                    ? Colors.white
                                    : Colors.black, // Ensure text color changes
                                fontWeight: isEventDay
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
    );
  }
}
