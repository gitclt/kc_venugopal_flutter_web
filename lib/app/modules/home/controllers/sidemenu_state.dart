import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/core/assets/image_assets.dart';
import 'package:kc_venugopal_flutter_web/app/domain/entity/menu_entity.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

class SidemenuState {
  final RxInt _selectedIndex = 0.obs;
  RxInt get selectedIndex => _selectedIndex;
  final RxInt _selectedsubIndex = 0.obs;
  RxInt get selectedsubIndex => _selectedsubIndex;
  List<MenuEntity> menus = [];

  void onInit() {
    addMenuItems();
  }

  void addMenuItems() {
    menus.add(
      MenuEntity(
        id: 0,
        menu: 'Dashboard',
        svgIcon: SvgAssets.dashboardIcon,
        items: [],
        onClick: () {
          Get.rootDelegate.toNamed(Routes.DASHBOARD);
        },
      ),
    );
    menus.add(
      MenuEntity(
        id: 1,
        menu: 'Support Requests',
        svgIcon: SvgAssets.supportReq,
        items: [],
        onClick: () {
          Get.rootDelegate.toNamed(Routes.SUPPORT_REQUEST);
        },
      ),
    );
    menus.add(
      MenuEntity(
        id: 1,
        menu: 'Program Schedule',
        svgIcon: SvgAssets.programSchedule,
        items: [],
        onClick: () {
          Get.rootDelegate.toNamed(Routes.PROGRAM_SCHEDULE);
        },
      ),
    );
    menus.add(
      MenuEntity(
        id: 1,
        menu: 'Reminders',
        svgIcon: SvgAssets.reminders,
        items: [],
        onClick: () {
          Get.rootDelegate.toNamed(Routes.REMINDER);
        },
      ),
    );

    // menus.add(
    //   MenuEntity(
    //     id: 1,
    //     menu: 'Master Settings',
    //     svgIcon: SvgAssets.master,
    //     items: [],
    //     onClick: () {
    //       //Get.rootDelegate.toNamed(Routes.SETTINGS);
    //     },
    //   ),
    // );
  }
}
