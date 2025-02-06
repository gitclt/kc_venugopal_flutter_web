import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  const RootView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, current) {
        return Scaffold(
          backgroundColor: AppColor.primary,
          body: Obx(
            () => (!controller.isLoading)
                ? (controller.isAuthenticated)
                    ? GetRouterOutlet(
                        initialRoute: Routes.HOME,
                      )
                    : GetRouterOutlet(
                        initialRoute: Routes.LOGIN,
                      )
                : _buildSplash(context),
          ),
        );
      },
    );
  }

  Widget _buildSplash(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImageAssets.mainLogo,
            fit: BoxFit.cover,
            color: Colors.white,
            // width: double.infinity,
            // height: MediaQuery.of(context).size.width * .8,
          ),
          const SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(
            color: AppColor.white,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'LOADING....',
            style: TextStyle(
              fontSize: 18,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
