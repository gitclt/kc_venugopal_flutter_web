import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_home_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/general_exception.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/internet_exceptions_widget.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/padding/common_padding.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/shimmer/shimmer_builder.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/texts/text_widget.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/status.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/controllers/program_schedule_detail_controller.dart';
import 'package:kc_venugopal_flutter_web/app/modules/program_schedule/views/widget/program_detail_widget.dart';

class ProgramScheduleDetailView
    extends GetView<ProgramScheduleDetailController> {
  const ProgramScheduleDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBgColor,
      body: CommonPagePadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(
              title: 'Program Schedule Detail',
              subTitle:
                  'Home > Dashboard > Program Schedule > Program Schedule Detail',
            ),
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
                          controller.getProgramDetail();
                        },
                      );
                    } else {
                      return GeneralExceptionWidget(onPress: () {
                        controller.getProgramDetail();
                      });
                    }

                  case Status.completed:
                    return Obx(() => SimpleContainer(
                          child: controller.dataDetail.isEmpty
                              ? Center(
                                  child: boldText('No Case Details Found')
                                      .paddingOnly(top: 50),
                                )
                              : ProgramDetailWidget(
                                  cons: s,
                                ),
                        ));
                }
              });
            }))
          ],
        ),
      ),
    );
  }
}
