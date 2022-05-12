import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';

class ProfileController extends GetxController {
  static final defaultTimeRange = DateTimeRange(
      start: DateTime.now(), end: DateTime.now().add(const Duration(days: 7)));
  final _exerciseProvider = ExerciseTrackProvider();
  Rx<int> exerciseMinutesWeekly = 0.obs;
  Rx<int> exerciseCaloriesWeekly = 0.obs;
  List<List<ExerciseTracker>> exerciseTracksWeekly = [];
  DateTimeRange exerciseDateRange = defaultTimeRange;
}
