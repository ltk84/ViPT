import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/daily_plan/daily_nutrition_controller.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_exercise_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_fasting_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_nutrition_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_step_screen.dart';
import 'package:vipt/app/modules/daily_plan/screens/daily_water_screen.dart';

import 'daily_exercise_controller.dart';

class DailyPlanController extends GetxController {
  Rx<int> currentTab = 0.obs;

  void changeTab(int newTabIndex) {
    int currentIndex = currentTab.value;
    switch (currentIndex) {
      case 0:
        Get.delete<DailyNutritionController>();
        break;
      case 1:
        Get.delete<DailyExerciseController>();
        break;
      case 2:
        break;
      case 3:
        break;
      case 4:
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
        return DailyFastingScreen();
      default:
        return DailyNutritionScreen();
    }
  }
}
