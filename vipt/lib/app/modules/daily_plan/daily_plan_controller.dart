import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/daily_plan/daily_nutrition_controller.dart';
import 'package:vipt/app/modules/daily_plan/daily_water_controller.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_exercise_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_fasting_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_nutrition_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_step_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_water_screen.dart';

import 'daily_exercise_controller.dart';
import 'daily_fasting_controller.dart';
import 'daily_step_controller.dart';

class DailyPlanController extends GetxController {
  Rx<int> currentTab = 4.obs;

  void changeTab(int newTabIndex) {
    int currentIndex = currentTab.value;
    if (currentIndex == newTabIndex) return;
    switch (currentIndex) {
      case 0:
        Get.delete<DailyNutritionController>();
        break;
      case 1:
        Get.delete<DailyExerciseController>();
        break;
      case 2:
        Get.delete<DailyWaterController>();
        break;
      case 3:
        Get.delete<DailyStepController>();
        break;
      case 4:
        Get.delete<DailyFastingController>();
        break;
      default:
        break;
    }
    currentTab.value = newTabIndex;
  }

  Widget getCurrentTab() {
    int index = currentTab.value;
    switch (index) {
      case 0:
        return DailyNutritionScreen();
      case 1:
        return DailyExerciseScreen();
      case 2:
        return DailyWaterScreen();
      case 3:
        return DailyStepScreen();
      case 4:
        return const DailyFastingScreen();
      default:
        return DailyNutritionScreen();
    }
  }
}
