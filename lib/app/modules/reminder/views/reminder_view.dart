import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/reminder_controller.dart';

class ReminderView extends GetView<ReminderController> {
  const ReminderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReminderView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ReminderView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
