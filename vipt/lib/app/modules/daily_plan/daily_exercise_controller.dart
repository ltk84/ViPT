import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyExerciseController extends GetxController with TrackerController {
  final _provider = ExerciseTrackProvider();
  Rx<int> calories = 0.obs;
  Rx<int> sessions = 0.obs;
  Rx<double> time = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();

    isLoading.value = true;
    await fetchTracksByDate(DateTime.now());
    isLoading.value = false;
  }

  @override
  fetchTracksByDate(DateTime date) async {
    this.date = date;
    tracks = await _provider.fetchByDate(date);
    calories.value = 0;
    sessions.value = 0;
    time.value = 0;
    tracks.map((e) {
      e = e as ExerciseTracker;
      calories.value += e.outtakeCalories;
      time.value += e.totalTime;
      sessions.value += e.sessionNumber;
    }).toList();
    update();
  }

  Future<void> addTrack(int newCalories) async {
    calories.value += newCalories;
    ExerciseTracker et = ExerciseTracker(
        date: date,
        outtakeCalories: newCalories,
        sessionNumber: 0,
        totalTime: 0);
    et = await _provider.add(et);
    tracks.add(et);
    update();

    _markRelevantTabToUpdate();
  }

  Future<void> deleteTrack(ExerciseTracker et) async {
    final result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          label: 'Xóa log luyện tập',
          content:
              'Bạn có chắc chắn muốn xóa log này? Bạn sẽ không thể hoàn tác lại thao tác này.',
          labelCancel: 'Không',
          labelOk: 'Có',
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () {
            Navigator.of(context).pop(OkCancelResult.ok);
          },
          primaryButtonColor: AppColor.exerciseBackgroundColor,
          buttonFactorOnMaxWidth: 0.32,
          buttonsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );

    if (result == OkCancelResult.ok) {
      calories.value -= et.outtakeCalories;
      tracks.remove(et);
      await _provider.delete(et.id ?? 0);
      update();

      _markRelevantTabToUpdate();
    }
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }

    if (!RefeshTabController.instance.isPlanTabNeedToUpdate) {
      RefeshTabController.instance.togglePlanTabUpdate();
    }
  }
}
