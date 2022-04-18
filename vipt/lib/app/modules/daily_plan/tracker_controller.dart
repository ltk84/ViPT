import 'package:get/get.dart';

import 'daily_plan_controller.dart';

abstract class TrackerController {
  final _parentController = Get.find<DailyPlanController>();
  void changeTab(int value) {
    _parentController.changeTab(value);
  }

  fetchTracksByDate(DateTime date);
}
