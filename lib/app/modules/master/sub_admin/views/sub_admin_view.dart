import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sub_admin_controller.dart';

class SubAdminView extends GetView<SubAdminController> {
  const SubAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
