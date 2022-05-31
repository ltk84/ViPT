import 'package:get/get.dart';
import 'package:vipt/app/data/models/tracker.dart';

import 'daily_plan_controller.dart';

abstract class TrackerController {
  final _parentController = Get.find<DailyPlanController>();
  late DateTime date;
  late List<Tracker> tracks;

  RxBool isLoading = false.obs;

  void changeTab(int value) {
    _parentController.changeTab(value);
  }

  fetchTracksByDate(DateTime date);
}
