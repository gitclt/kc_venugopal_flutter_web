import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/common_strings.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/pagination/pagination_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/dashboard/controllers/all_activity_controller.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/views/widget/program_list_widget.dart';
import 'package:sizer/sizer.dart';

class ActivityDetailView extends GetView<AllActivityController> {
  const ActivityDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: CommonPagePadding(
        child: Column(
          children: [
            HomeAppBar(
              title: 'All Activities',
              subTitle: 'Home > Dashboard > All Activities',
            ),
            SimpleContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => Wrap(
                        spacing: 8,
                        children: List.generate(controller.todaysData.length,
                            (index) {
                          return ChoiceChip(
                            label: columnText(
                                capitalizeLetter(controller
                                    .todaysData[index].type
                                    .toString()),
                                10.sp),
                            selected: controller.selectedType.value ==
                                controller.todaysData[index].type.toString(),
                            onSelected: (selected) =>
                                controller.updateSelectedType(controller
                                    .todaysData[index].type
                                    .toString()),
                            selectedColor: Color.fromRGBO(61, 66, 223, 0.1),
                            backgroundColor: Color.fromRGBO(61, 66, 223, 0.1),
                            labelStyle: TextStyle(
                              color: controller.selectedType.value ==
                                      controller.todaysData[index].type
                                          .toString()
                                  ? AppColor.primary
                                  : Colors.black,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: controller.selectedType.value ==
                                        controller.todaysData[index].type
                                            .toString()
                                    ? AppColor
                                        .primary // Blue border when selected
                                    : Colors
                                        .transparent, // No border when unselected
                                width: 2, // Border width
                              ),
                              borderRadius:
                                  BorderRadius.circular(20), // Rounded corners
                            ),
                          );
                        }),
                      )),
                  16.height,

                  // LOADING INDICATOR
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.activityData.isEmpty) {
                      return Center(
                        child: columnText('No Cases Found', 12.sp)
                            .paddingOnly(top: 20),
                      );
                    }
                    return SizedBox.shrink();
                  }),

                  // REQUEST LIST
                  Flexible(
                    child: Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.activityData.length,
                          itemBuilder: (context, index) {
                            final item = controller.activityData[index];
                            return ProgramListWidget(
                              time: item.time ?? '',
                              address: item.address ?? '',
                              title: item.title ?? '',
                              issue: item.category ?? '',
                              description: item.description ?? '',
                              person: item.contactPerson!.isNotEmpty
                                  ? item.contactPerson!.first.contactPerson
                                  : null,
                              date: item.date ?? '',
                              mobile: item.mobile ?? '',
                              status: item.status ?? '',
                              onTap: () {},
                            );
                          }).paddingOnly(top: 10),
                    ),
                  ),
                  10.height,
                  Obx(
                    () => controller.isLoading.value ||
                            controller.activityData.isEmpty
                        ? SizedBox.shrink()
                        : controller.pageSize.value != 0
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
