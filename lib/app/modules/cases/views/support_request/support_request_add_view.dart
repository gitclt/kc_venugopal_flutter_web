import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/modules/cases/controllers/cases_controller.dart';
import 'package:kc_venugopal_flutter_web/app/modules/cases/views/widgets/case_info_tab_view.dart';
import 'package:kc_venugopal_flutter_web/app/modules/cases/views/widgets/personal_info_tab_view.dart';

class SupportRequestAddView extends GetView<CasesController> {
  const SupportRequestAddView({super.key});

  @override
  Widget build(BuildContext context) {
     return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBgColor,
        body: LayoutBuilder(builder: (context, s) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.height,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabBar(
                      controller: controller.tabController,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        labelColor: AppColor.primary,
                        indicatorColor: AppColor.primary,
                        isScrollable: true,
                        indicatorWeight: 2.0,
                        padding: EdgeInsets.zero, // Add this line
                        tabAlignment: TabAlignment.start,
                        unselectedLabelStyle:
                            const TextStyle(fontWeight: FontWeight.w400),
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: 'Personal Information',
                          ),
                          Tab(
                            text: 'Case Information',
                          )
                        ]),
                    10.height,
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            PersonalInfoTabView(
                              cons: s,
                            ),
                            CaseInfoTabView(cons: s)
                          ]),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}