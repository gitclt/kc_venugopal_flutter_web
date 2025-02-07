import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/assembly_controller.dart';

class AssemblyView extends GetView<AssemblyController> {
  const AssemblyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AssemblyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AssemblyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
