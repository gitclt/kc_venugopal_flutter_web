import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController(text: '').obs;
  final passwordController = TextEditingController(text: '').obs;
  final isLoading = false.obs;
  final isVisiblePassword = false.obs;
  @override
  void onInit() {
    super.onInit();
  }
}
