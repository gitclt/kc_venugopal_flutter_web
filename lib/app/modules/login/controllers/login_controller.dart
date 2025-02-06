import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kc_venugopal_flutter_web/app/data/local/user_preference/user_prefrence_view_model.dart';
import 'package:kc_venugopal_flutter_web/app/data/network/network_api_services.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/login/login_repository.dart';
import 'package:kc_venugopal_flutter_web/app/domain/repositories/profile/profile_repository.dart';
import 'package:kc_venugopal_flutter_web/app/routes/app_pages.dart';
import 'package:kc_venugopal_flutter_web/app/utils/utils.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController(text: 'admin').obs;
  final passwordController = TextEditingController(text: 'admin123').obs;
  final isLoading = false.obs;
  final isVisiblePassword = false.obs;
  final formkey = GlobalKey<FormState>();

  final profileRepo = ProfileRepository();
  final loginRepo = LoginRepository();
  final apiServices = NetworkApiServices();
  UserPreference userPreference = UserPreference();
  String type = 'admin';

  void login() async {
    isLoading(true);

    try {
      String password =
          passwordController.value.text.trim().replaceAll('&', 'amp;');
      String temp =
          "username=${emailController.value.text.trim()}&password=$password&type=$type";

      List<int> encDataByte =
          utf8.encode(temp); // Convert string to UTF-8 bytes
      String encodedData = base64Encode(encDataByte); // Encode bytes to Base64

      final response = await loginRepo.loginApi(encodedData);

      response.fold((failure) {
        isLoading(false);
        Utils.snackBar('Login', failure.message);
      }, (sucess) async {
        if (sucess.data != null) {
          await userPreference.addToken(sucess.data!.encKey ?? '');

          if (sucess.data != null) {
            final res = await profileRepo
                .getProfileView(sucess.data!.encKey.toString());

            res.fold(
              (failure) {
                isLoading(false);
                Utils.snackBar('Profile', failure.message);
              },
              (resData) {
                if (resData.data != null) {
                  userPreference.saveUser(resData.data!.first).then(
                    (s) {
                      Get.rootDelegate.offNamed(Routes.HOME);
                    },
                  );
                }
              },
            );
          }
        }
      });
    } finally {
      isLoading(false);
    }
  }
}
