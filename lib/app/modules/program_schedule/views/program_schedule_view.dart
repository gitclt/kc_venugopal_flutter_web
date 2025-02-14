import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/program_schedule_controller.dart';

class ProgramScheduleView extends GetView<ProgramScheduleController> {
  const ProgramScheduleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProgramScheduleView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ProgramScheduleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
