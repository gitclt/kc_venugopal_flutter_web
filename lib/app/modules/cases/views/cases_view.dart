import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cases_controller.dart';

class CasesView extends GetView<CasesController> {
  const CasesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CasesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CasesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
