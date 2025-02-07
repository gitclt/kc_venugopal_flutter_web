import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/priority_controller.dart';

class PriorityView extends GetView<PriorityController> {
  const PriorityView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PriorityView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PriorityView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
