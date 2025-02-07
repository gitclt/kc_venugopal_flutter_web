import 'package:kc_venugopal_flutter_web/app/constants/strings.dart';
import 'package:kc_venugopal_flutter_web/app/model/auth/auth_model.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserPreference {
  Future<bool> saveUser(
    UserData userData,
  ) async {
    LocalStorageKey.accountId = userData.accountId ?? '';
    LocalStorageKey.userData = userData;

    return true;
  }

  Future<dynamic> getUser() async {
    var box = Hive.box('token');

    // SharedPreferences sp = await SharedPreferences.getInstance();

    String? storedValue = box.get('token');

    return storedValue;
  }

  Future<void> addToken(String token) async {
    final box1 = Hive.box('token');

    await box1.put('token', token);

    await box1.add(token);
  }

  Future<void> addMac(String type) async {
    final box1 = Hive.box('token');

    await box1.put('macId', type);
  }

  Future<bool> removeUser() async {
    final tokenBox = Hive.box('token');

    tokenBox.clear();
    return true;
  }

  void goToSplash() async {
    Get.rootDelegate.offNamed(Routes.LOGIN);
  }

  // void goToSplas1h() async {
  //   Get.rootDelegate.offNamed(Routes.root);
  // }
}
