import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/dates/select_date_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/drop_down/drop_down3_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/general_exception.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/internet_exceptions_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/shimmer/shimmer_builder.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/textform_fields/text_form_field.dart/add_new_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/modules/support_request/views/widget/container_widget.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';
import 'package:sizer/sizer.dart';

import '../controllers/support_request_controller.dart';

class SupportRequestView extends GetView<SupportRequestController> {
  const SupportRequestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CommonPagePadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeAppBar(
            title: 'Support Requests',
            subTitle: 'Home > Dashboard > Support Requests',
            isAdd: true,
            onClick: () {
              // Get.rootDelegate.toNamed(Routes.ADD_PRIORITY);
            },
          ),
          20.height,
          PageContainer(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText('Filter By'),
              Wrap(
                spacing: Responsive.isDesktop(context) ? 2.w : 1.8.w,
                runSpacing: 15,
                children: [
                  AddTextFieldWidget(
                    label: 'From Date',
                    // readonly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today_outlined, size: 20),
                      onPressed: () async {
                        selectDate(context, controller.fromDateController);
                      },
                    ),
                    textController: controller.fromDateController,
                  ),
                  AddTextFieldWidget(
                    label: 'To Date',
                    // readonly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today_outlined, size: 20),
                      onPressed: () async {
                        selectToDate(context, controller.toDateController);
                      },
                    ),
                    textController: controller.toDateController,
                  ),
                  DropDown3Widget(
                    label: 'Status',
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
                      label: 'Category',
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
                      label: 'Priority',
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
                    label: 'Keyword',
                    // readonly: true,

                    textController: controller.keywordController,
                  ),
                ],
              )
            ],
          )),
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
                        //controller.getPriority();
                      },
                    );
                  } else {
                    return GeneralExceptionWidget(onPress: () {
                      // controller.getPriority();
                    });
                  }

                case Status.completed:
                  return Obx(() => PageContainer(
                          child: Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: controller.data.length,
                                  itemBuilder: (context, index) {
                                    final item = controller.data[index];
                                    return ContainerWidget(
                                      lineColor: AppColor.appointTextColor,
                                      title: item.title ?? '',
                                      issue: item.category ?? '',
                                      description: item.description ?? '',
                                      person: item.contactPerson!.isNotEmpty
                                          ? item.contactPerson!.first
                                              .contactPerson
                                          : '',
                                      date: item.date ?? '',
                                      mobile: item.mobile ?? '',
                                      status: item.status ?? '',
                                      statusColor: Colors.yellow,
                                    );
                                  }))
                        ],
                      )));
              }
            });
          }))
        ],
      ),
    ));
  }
}
