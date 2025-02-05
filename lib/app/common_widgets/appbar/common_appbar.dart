
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/container/simple_container.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/popup/common_popup.dart';
import 'package:kc_venugopal_flutter_web/app/common_widgets/popup/user/admin_popup.dart';
import 'package:kc_venugopal_flutter_web/app/constants/colors.dart';
import 'package:kc_venugopal_flutter_web/app/core/extention.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/responsive.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CommonAppBar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.white,
      automaticallyImplyLeading: false,

      centerTitle: false,
      elevation: .2,
    
      leading: !ResponsiveWidget.isDesktop(context)
          ? IconButton(
              onPressed: () {
                //if(scaffoldKey.currentState=null )
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: AppColor.black,
              ))
          : null,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // SimpleContainer(
            //   child: InkWell(
            //     onTap: () {
            //       Get.rootDelegate.toNamed(Routes.NOTIFICATION);
            //     },
            //     child: const Icon(
            //       Icons.notifications,
            //       color: AppColor.textGrayColor,
            //       size: 20,
            //     ),
            //   ),
            // ),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (_) {
                        return Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0,
                              child: AdminPopUp(onSelected: (value) async {
                                if (value == 'Profile') {
                                  //Get.rootDelegate.toNamed(Routes.profile);
                                } else if (value == 'Change Password') {
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (_) {
                                  //       return const ChangePasswordPopUp();
                                  //     });
                                } else {
                                  dynamic returnResponse = await commonDialog(
                                      title: "Logout",
                                      subTitle: "Are you sure want to logout?",
                                      titleIcon: Icons.logout);

                                  if (returnResponse == true) {
                                    // UserPreference userPreference =
                                    //     UserPreference();
                                    // userPreference.removeUser();

                                    Get.rootDelegate.offNamed(Routes.LOGIN);
                                  }
                                }
                              }),
                            ),
                          ],
                        );
                      });
                },
                child: SimpleContainer(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_box_outlined,
                        color: AppColor.textGrayColor,
                        size: 20,
                      ),
                      5.width,
                      Text(
                        'Admin',
                        // LocalStorageKey.userData.studentname!.toUpperCase(),
                        style: const TextStyle(
                            color: AppColor.textGrayColor, fontSize: 12),
                      ),
                    ],
                  ),
                )),
          ],
        ).paddingOnly(right: 20)
        // IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        // IconButton(onPressed: () {}, icon: svgWidget(ImageAssets.appbarIcon))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
