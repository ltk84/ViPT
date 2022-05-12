import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';

// TODO: giải quyết vấn đề chuyển tab không reload data
class ProfileController extends GetxController {
  static final DateTime _firstDateOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday));
  static final DateTime _lastDateOfWeek =
      _firstDateOfWeek.add(const Duration(days: 7));
  static final DateTimeRange defaultDateTime =
      DateTimeRange(start: _firstDateOfWeek, end: _lastDateOfWeek);

  final _exerciseProvider = ExerciseTrackProvider();

  Rx<int> exerciseMinutesWeekly = 0.obs;
  Rx<int> exerciseCaloriesWeekly = 0.obs;
  RxList<List<ExerciseTracker>> exerciseTracksWeekly =
      <List<ExerciseTracker>>[].obs;
  Rx<DateTimeRange> exerciseDateRange = defaultDateTime.obs;

  Rx<String> get startDateStr =>
      '${exerciseDateRange.value.start.day}/${exerciseDateRange.value.start.month}/${exerciseDateRange.value.start.year}'
          .obs;
  Rx<String> get endDateStr =>
      '${exerciseDateRange.value.end.day}/${exerciseDateRange.value.end.month}/${exerciseDateRange.value.end.year}'
          .obs;
  RxList<int> get exerciseCaloList {
    return List<int>.generate(exerciseTracksWeekly.length, (index) {
      int count = 0;
      for (var element in exerciseTracksWeekly[index]) {
        count += element.outtakeCalories;
      }
      return count;
    }).obs;
  }

  @override
  void onInit() async {
    super.onInit();
    await loadExerciseTracks();
  }

  Future<void> changeExerciseDateRange(
      DateTime startDate, DateTime endDate) async {
    exerciseDateRange.value = DateTimeRange(start: startDate, end: endDate);
    await loadExerciseTracks();
  }

  Future<void> loadExerciseTracks() async {
    exerciseCaloriesWeekly.value = 0;
    exerciseMinutesWeekly.value = 0;
    exerciseTracksWeekly.clear();

    for (int i = 0; i < 7; i++) {
      var exerciseTracks = await _exerciseProvider
          .fetchByDate(exerciseDateRange.value.start.add(Duration(days: i)));
      for (var element in exerciseTracks) {
        exerciseCaloriesWeekly.value += element.outtakeCalories;
        exerciseMinutesWeekly.value += element.totalTime;
      }
      exerciseTracksWeekly.add(exerciseTracks);
    }
  }
}
