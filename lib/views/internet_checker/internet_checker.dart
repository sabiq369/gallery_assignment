import 'package:flutter/material.dart';
import 'package:gallery/views/internet_checker/controller/internet_checker_controller.dart';
import 'package:get/get.dart';

class InternetChecker extends StatelessWidget {
  InternetChecker({super.key});
  final InternetCheckerController internetCheckerController =
      Get.put(InternetCheckerController());

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
