import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/daily_plan/daily_plan_controller.dart';

class DailyPlanScreen extends StatelessWidget {
  DailyPlanScreen({Key? key}) : super(key: key);

  final _controller = Get.find<DailyPlanController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.getCurrentTab());
  }
}
