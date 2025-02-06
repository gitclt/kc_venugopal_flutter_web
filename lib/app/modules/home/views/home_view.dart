import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/appbar/common_appbar.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/content_place_widget.dart';
import 'package:kc_venugopal_flutter_web/app/modules/home/views/widget/sidemenu_view.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(width: 250, child: SidemenuView(scaffoldKey: _scaffoldKey))
          : null,
      //  appBar: CommonAppBar(scaffoldKey: _scaffoldKey),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Flexible(
                flex: 2,
                child: SidemenuView(
                  scaffoldKey: _scaffoldKey,
                ),
              ),
            Flexible(
              flex: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar(scaffoldKey: _scaffoldKey),
                  const Expanded(child: ContentPlaceWidget()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
