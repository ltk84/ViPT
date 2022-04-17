import 'package:get/get.dart';
import 'package:vipt/app/modules/daily_plan/daily_plan_controller.dart';

class DailyNutritionController extends GetxController {
  final _parentController = Get.find<DailyPlanController>();
  void changeTab(int value) {
    _parentController.changeTab(value);
  }
}
