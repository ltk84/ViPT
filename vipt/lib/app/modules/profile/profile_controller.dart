import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/models/weight_tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/providers/meal_nutrition_track_provider.dart';
import 'package:vipt/app/data/providers/water_track_provider.dart';
import 'package:vipt/app/data/providers/weight_tracker_provider.dart';

// TODO: giải quyết vấn đề chuyển tab không reload data
class ProfileController extends GetxController {
  static final DateTime _firstDateOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  static final DateTime _lastDateOfWeek =
      _firstDateOfWeek.add(const Duration(days: 7));
  static final DateTimeRange defaultDateTime =
      DateTimeRange(start: _firstDateOfWeek, end: _lastDateOfWeek);

  final _exerciseProvider = ExerciseTrackProvider();
  final _nutritionProvider = MealNutritionTrackProvider();
  final _waterProvider = WaterTrackProvider();
  final _weightProvider = WeightTrackerProvider();

  // ------------------------ Exercise Track ------------------------ //
  Rx<int> exerciseMinutesWeekly = 0.obs;
  Rx<int> exerciseCaloriesWeekly = 0.obs;
  RxList<List<ExerciseTracker>> exerciseTracksWeekly =
      <List<ExerciseTracker>>[[], [], [], [], [], [], []].obs;
  Rx<DateTimeRange> exerciseDateRange = defaultDateTime.obs;

  Rx<String> get exerciseStartDateStr =>
      '${exerciseDateRange.value.start.day}/${exerciseDateRange.value.start.month}/${exerciseDateRange.value.start.year}'
          .obs;
  Rx<String> get exerciseEndDateStr =>
      '${exerciseDateRange.value.end.day}/${exerciseDateRange.value.end.month}/${exerciseDateRange.value.end.year}'
          .obs;
  List<int> get exerciseCaloList {
    List<int> list = List<int>.generate(exerciseTracksWeekly.length, (index) {
      int count = 0;
      for (var element in exerciseTracksWeekly[index]) {
        count += element.outtakeCalories;
      }
      return count;
    });
    list.add(1);
    return list;
  }

  Future<void> changeExerciseDateRange(
      DateTime startDate, DateTime endDate) async {
    exerciseDateRange.value = DateTimeRange(start: startDate, end: endDate);
    await loadExerciseTracks();
  }

  Future<void> loadExerciseTracks() async {
    exerciseCaloriesWeekly.value = 0;
    exerciseMinutesWeekly.value = 0;

    for (int i = 0; i < 7; i++) {
      var exerciseTracks = await _exerciseProvider
          .fetchByDate(exerciseDateRange.value.start.add(Duration(days: i)));
      for (var element in exerciseTracks) {
        exerciseCaloriesWeekly.value += element.outtakeCalories;
        exerciseMinutesWeekly.value += element.totalTime;
      }
      exerciseTracksWeekly[i] = exerciseTracks;
    }
  }
  // ------------------------ Exercise Track ------------------------ //

  // ------------------------ Nutrition Track ------------------------ //
  Rx<int> nutritionCaloWeekly = 0.obs;
  RxList<List<MealNutritionTracker>> nutritionTracksWeekly =
      <List<MealNutritionTracker>>[[], [], [], [], [], [], []].obs;
  Rx<DateTimeRange> nutritionDateRange = defaultDateTime.obs;

  Rx<String> get nutritionStartDateStr =>
      '${nutritionDateRange.value.start.day}/${nutritionDateRange.value.start.month}/${nutritionDateRange.value.start.year}'
          .obs;
  Rx<String> get nutritionEndDateStr =>
      '${nutritionDateRange.value.end.day}/${nutritionDateRange.value.end.month}/${nutritionDateRange.value.end.year}'
          .obs;
  List<int> get nutritionCaloList {
    List<int> list = List<int>.generate(nutritionTracksWeekly.length, (index) {
      int count = 0;
      for (var element in nutritionTracksWeekly[index]) {
        count += element.intakeCalories;
      }
      return count;
    });
    list.add(1);
    return list;
  }

  Future<void> loadNutritionTracks() async {
    nutritionCaloWeekly.value = 0;
    for (int i = 0; i < 7; i++) {
      var nutritionTracks = await _nutritionProvider
          .fetchByDate(exerciseDateRange.value.start.add(Duration(days: i)));
      for (var element in nutritionTracks) {
        nutritionCaloWeekly.value += element.intakeCalories;
      }
      nutritionTracksWeekly[i] = nutritionTracks;
    }
  }

  Future<void> changeNutritionDateChange(
      DateTime startDate, DateTime endDate) async {
    nutritionDateRange.value = DateTimeRange(start: startDate, end: endDate);
    await loadNutritionTracks();
  }
  // ------------------------ Nutrition Track ------------------------ //

  // ------------------------ Water Track ------------------------ //
  Rx<int> waterVolumeWeekly = 0.obs;
  RxList<List<WaterTracker>> waterTracksWeekly =
      <List<WaterTracker>>[[], [], [], [], [], [], []].obs;
  Rx<DateTimeRange> waterDateRange = defaultDateTime.obs;

  Rx<String> get waterStartDateStr =>
      '${waterDateRange.value.start.day}/${waterDateRange.value.start.month}/${waterDateRange.value.start.year}'
          .obs;
  Rx<String> get waterEndDateStr =>
      '${waterDateRange.value.end.day}/${waterDateRange.value.end.month}/${waterDateRange.value.end.year}'
          .obs;
  List<int> get waterVolumeList {
    List<int> list = List<int>.generate(waterTracksWeekly.length, (index) {
      int count = 0;
      for (var element in waterTracksWeekly[index]) {
        count += element.waterVolume;
      }
      return count;
    });
    list.add(1);
    return list;
  }

  Future<void> loadWaterTracks() async {
    waterVolumeWeekly.value = 0;
    for (int i = 0; i < 7; i++) {
      var waterTracks = await _waterProvider
          .fetchByDate(waterDateRange.value.start.add(Duration(days: i)));
      for (var element in waterTracks) {
        waterVolumeWeekly.value += element.waterVolume;
      }
      waterTracksWeekly[i] = waterTracks;
    }
  }

  Future<void> changeWaterDateChange(
      DateTime startDate, DateTime endDate) async {
    waterDateRange.value = DateTimeRange(start: startDate, end: endDate);
    await loadWaterTracks();
  }
  // ------------------------ Water Track ------------------------ //

  // ------------------------ Weight Track ------------------------ //
  Rx<DateTimeRange> weightDateRange = defaultDateTime.obs;
  RxList<WeightTracker> allWeightTracks = <WeightTracker>[].obs;

  Rx<String> get weightStartDateStr =>
      '${weightDateRange.value.start.day}/${weightDateRange.value.start.month}/${weightDateRange.value.start.year}'
          .obs;
  Rx<String> get weightEndDateStr =>
      '${weightDateRange.value.end.day}/${weightDateRange.value.end.month}/${weightDateRange.value.end.year}'
          .obs;

  Map<DateTime, double> get weightTrackList {
    allWeightTracks.sort((x, y) {
      return x.date.compareTo(y.date);
    });
    return allWeightTracks.isEmpty
        ? {
            DateTime.parse('2022/11/2'): 0,
          }
        : {for (var e in allWeightTracks) e.date: e.weight.toDouble()};
  }

  Future<void> loadWeightTracks() async {
    allWeightTracks.value = await _weightProvider.fetchAll();
  }
  // ------------------------ Weight Track ------------------------ //

  @override
  void onInit() async {
    super.onInit();
    await loadExerciseTracks();
    await loadNutritionTracks();
    await loadWaterTracks();
    await loadWeightTracks();
  }
}
