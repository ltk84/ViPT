import 'package:get/get.dart';

import 'daily_plan_controller.dart';

class DailyExerciseController extends GetxController {
  final _parentController = Get.find<DailyPlanController>();
  void changeTab(int value) {
    _parentController.changeTab(value);
  }
}
