import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/button/common_button.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/general_exception.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/internet_exceptions_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/pagination/pagination_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/shimmer/shimmer_builder.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/views/widget/program_list_widget.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

import '../controllers/program_schedule_controller.dart';

class ProgramScheduleView extends GetView<ProgramScheduleController> {
  const ProgramScheduleView({super.key});
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.18;
    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: CommonPagePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(
              title: 'Program Schedule',
              subTitle: 'Home > Dashboard > Program Schedule',
              isAdd: true,
              onClick: () {
                Get.rootDelegate.toNamed(Routes.ADD_PROGRAM_SCHEDULE);
              },
            ),
          
            SimpleContainer(
                color: AppColor.borderColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // columnText('Filter By', 24),
                    10.height,
                    Wrap(
                      spacing: Responsive.isDesktop(context) ? 2.w : 1.8.w,
                      runSpacing: Responsive.isDesktop(context) ? 2.w : 1.8.w,
                      alignment: WrapAlignment.start,
                      children: [
                        AddTextFieldWidget(
                          width: width,
                          labelText: 'From Date',
                          hintText: 'From Date',
                          // readonly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today_outlined,
                                size: 20),
                            onPressed: () async {
                              selectDate(
                                  context, controller.fromDateController);
                            },
                          ),
                          textController: controller.fromDateController,
                        ),
                        AddTextFieldWidget(
                          width: width,
                          labelText: 'To Date',
                          hintText: 'To Date',
                          // readonly: true,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_today_outlined,
                                size: 20),
                            onPressed: () async {
                              selectToDate(
                                  context, controller.toDateController);
                            },
                          ),
                          textController: controller.toDateController,
                        ),
                        DropDown3Widget(
                          width: width,
                          hint: '--Select Status--',
                          selectedItem: controller.statusFilter.id == null
                              ? null
                              : controller.statusFilter,
                          items: controller.statusDropList,
                          onChanged: (data) async {
                            if (data == null) return;
                            controller.statusFilter = data;
                          },
                        ),
                        Obx(
                          () => DropDown3Widget(
                            width: width,
                            //label: 'Category',
                            hint: '--Select Category--',
                            selectedItem: controller.categoryFilter.id == null
                                ? null
                                : controller.categoryFilter,
                            items: controller.categoryDropList,
                            isLoading: controller.isDropLoading.value,
                            onChanged: (data) async {
                              if (data == null) return;
                              controller.categoryFilter = data;
                            },
                          ),
                        ),
                        Obx(
                          () => DropDown3Widget(
                            width: width,
                            // label: 'Priority',
                            hint: '--Select Priority--',
                            isLoading: controller.isDropLoading.value,
                            selectedItem: controller.priorityFilter.id == null
                                ? null
                                : controller.priorityFilter,
                            items: controller.priorityDropList,
                            onChanged: (data) async {
                              if (data == null) return;
                              controller.priorityFilter = data;
                            },
                          ),
                        ),
                        AddTextFieldWidget(
                          width: width,
                          labelText: 'Keyword',
                          hintText: 'Keyword',
                          // readonly: true,

                          textController: controller.keywordController,
                        ),
                        CommonButton(
                            width: width,
                            onClick: () {
                              controller.getProgramSchedules();
                            },
                            label: 'Search'),
                      ],
                    ),
                    10.height,
                    // Align(
                    //   alignment: Alignment.bottomLeft,
                    //   child: CommonButton(
                    //       width: width,
                    //       onClick: () {
                    //         controller.getProgramSchedules();
                    //       },
                    //       label: 'Search'),
                    // )
                  ],
                )),
            20.height,
            Expanded(child: LayoutBuilder(builder: (context, s) {
              return Obx(() {
                switch (controller.rxRequestStatus.value) {
                  case Status.loading:
                    return ShimmerBuilder(
                      rowCount: 5,
                      sizes: [
                        s.maxWidth * 0.05,
                        s.maxWidth * 0.3,
                        s.maxWidth * 0.055,
                        s.maxWidth * 0.2,
                        s.maxWidth * 0.3
                      ],
                    ).paddingAll(10);
                  case Status.error:
                    if (controller.error.value == 'No internet') {
                      return InterNetExceptionWidget(
                        onPress: () {
                          controller.getProgramSchedules();
                        },
                      );
                    } else {
                      return GeneralExceptionWidget(onPress: () {
                        controller.getProgramSchedules();
                      });
                    }

                  case Status.completed:
                    return Obx(() => SimpleContainer(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            controller.data.isEmpty
                                ? Center(
                                    child: boldText('No Cases Found')
                                        .paddingOnly(top: 50),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: controller.data.length,
                                        itemBuilder: (context, index) {
                                          final item = controller.data[index];
                                          return ProgramListWidget(
                                            time: item.time ?? '',
                                            address: item.address ?? '',
                                            title: item.title ?? '',
                                            issue: item.category ?? '',
                                            description: item.description ?? '',
                                            person:
                                                item.contactPerson!.isNotEmpty
                                                    ? item.contactPerson!.first
                                                        .contactPerson
                                                    : null,
                                            date: item.date ?? '',
                                            mobile: item.mobile ?? '',
                                            status: item.status ?? '',
                                            onTap: () {
                                              controller.programId =
                                                  item.id.toString();
                                              controller.getProgramDetail();
                                              Get.rootDelegate.toNamed(Routes
                                                  .PROGRAM_SCHEDULE_DETAIL);
                                            },
                                          );
                                        }).paddingOnly(top: 10),
                                  ),
                            10.height,
                            Obx(
                              () => controller.pageSize.value != 0
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: PaginationWidget(
                                        alignment: Alignment.centerRight,
                                        totalPages: controller.totalCount.value,
                                        currentPage: controller.pageIndex.value,
                                        onPageSelected: controller.changePage,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        )));
                }
              });
            }))
          ],
        ),
      ),
    );
  }
}
