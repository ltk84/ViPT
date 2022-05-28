import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/step_tracker.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/models/weight_tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/providers/meal_nutrition_track_provider.dart';
import 'package:vipt/app/data/providers/step_tracker_provider.dart';
import 'package:vipt/app/data/providers/water_track_provider.dart';
import 'package:vipt/app/data/providers/weight_tracker_provider.dart';
import 'package:vipt/app/modules/daily_plan/daily_step_controller.dart';

class ProfileController extends GetxController {
  static final DateTime _firstDateOfWeek =
      DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  static final DateTime _lastDateOfWeek =
      _firstDateOfWeek.add(const Duration(days: 7));
  static final DateTimeRange defaultDateTime =
      DateTimeRange(start: _firstDateOfWeek, end: _lastDateOfWeek);
  static final DateTimeRange defaultWeightDateRange =
      DateTimeRange(start: _firstDateOfWeek, end: DateTime.now());
  static const String defaultImageStr = '';
  static const String beforeImagePrefKey = 'beforeImage';
  static const String afterImagePrefKey = 'afterImage';

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  final _exerciseProvider = ExerciseTrackProvider();
  final _nutritionProvider = MealNutritionTrackProvider();
  final _waterProvider = WaterTrackProvider();
  final _weightProvider = WeightTrackerProvider();
  final _stepProvider = StepTrackerProvider();

  final _stepTrackController = Get.put(DailyStepController());

  // ------------------------ Exercise Track ------------------------ //
  Rx<double> exerciseSecondsWeekly = 0.0.obs;
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
    exerciseSecondsWeekly.value = 0;

    for (int i = 0; i < 7; i++) {
      var exerciseTracks = await _exerciseProvider
          .fetchByDate(exerciseDateRange.value.start.add(Duration(days: i)));
      int temptOuttakeCalories = 0;
      double temptTotalTime = 0;
      for (var element in exerciseTracks) {
        temptOuttakeCalories += element.outtakeCalories;
        temptTotalTime += (element.totalTime);
      }

      exerciseCaloriesWeekly.value += temptOuttakeCalories;
      exerciseSecondsWeekly.value += temptTotalTime;
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
      int temptIntakeCalories = 0;
      for (var element in nutritionTracks) {
        temptIntakeCalories += element.intakeCalories;
      }
      nutritionCaloWeekly.value += temptIntakeCalories;
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

      int temptWaterVolume = 0;
      for (var element in waterTracks) {
        temptWaterVolume += element.waterVolume;
      }
      waterVolumeWeekly.value += temptWaterVolume;
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
  Rx<DateTimeRange> weightDateRange = defaultWeightDateRange.obs;
  RxList<WeightTracker> allWeightTracks = <WeightTracker>[].obs;
  // Map<DateTime, double> defaultMap = {
  //   DateTime(2022, 1, 1): -1,
  //   DateTime(2022, 1, 2): 75,
  // };

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

    return allWeightTracks.length == 1 ? fakeMap() : convertToMap();
  }

  Map<DateTime, double> convertToMap() {
    return {for (var e in allWeightTracks) e.date: e.weight.toDouble()};
  }

  Map<DateTime, double> fakeMap() {
    var map = convertToMap();

    map.addAll(
        {allWeightTracks.first.date.subtract(const Duration(days: 1)): 0});

    return map;
  }

  Future<void> loadWeightTracks() async {
    allWeightTracks.clear();
    int duration = weightDateRange.value.duration.inDays + 1;
    for (int i = 0; i < duration; i++) {
      DateTime fetchDate = weightDateRange.value.start.add(Duration(days: i));
      var weighTracks = await _weightProvider.fetchByDate(fetchDate);
      weighTracks.sort((x, y) => x.weight - y.weight);
      if (weighTracks.isNotEmpty) {
        allWeightTracks.add(weighTracks.last);
      }
    }
  }

  Future<void> changeWeighDateRange(
      DateTime startDate, DateTime endDate) async {
    if (startDate.day == endDate.day &&
        startDate.month == endDate.month &&
        startDate.year == endDate.year) {
      startDate = startDate.subtract(const Duration(days: 1));
    }
    weightDateRange.value = DateTimeRange(start: startDate, end: endDate);
    await loadWeightTracks();
  }
  // ------------------------ Weight Track ------------------------ //

  // ------------------------ Step Track ------------------------ //
  Rx<int> stepCountWeekly = 0.obs;
  RxList<List<StepTracker>> stepTracksWeekly =
      <List<StepTracker>>[[], [], [], [], [], [], []].obs;
  Rx<DateTimeRange> stepDateRange = defaultDateTime.obs;

  Rx<String> get stepStartDateStr =>
      '${stepDateRange.value.start.day}/${stepDateRange.value.start.month}/${stepDateRange.value.start.year}'
          .obs;
  Rx<String> get stepEndDateStr =>
      '${stepDateRange.value.end.day}/${stepDateRange.value.end.month}/${stepDateRange.value.end.year}'
          .obs;
  List<int> get stepCountList {
    List<int> list = List<int>.generate(stepTracksWeekly.length, (index) {
      int count = 0;
      for (var element in stepTracksWeekly[index]) {
        count += element.stepCount;
      }
      return count;
    });
    list.add(1);
    return list;
  }

  Future<void> loadStepTracks() async {
    stepCountWeekly.value = 0;
    for (int i = 0; i < 7; i++) {
      var stepTracks = await _stepProvider
          .fetchByDate(stepDateRange.value.start.add(Duration(days: i)));
      int temptStep = 0;
      for (var element in stepTracks) {
        temptStep += element.stepCount;
      }
      stepCountWeekly.value += temptStep;
      stepTracksWeekly[i] = stepTracks;
    }
  }

  Future<void> changeStepDateChange(
      DateTime startDate, DateTime endDate) async {
    stepDateRange.value = DateTimeRange(start: startDate, end: endDate);
    await loadStepTracks();
  }

  Future<void> updateStepTrackData() async {
    await _stepTrackController.updateDailyStepTrackToDB();
    // Get.delete<DailyStepController>();
  }

  // ------------------------ Step Track ------------------------ //

  // ------------------------ Image Before - After ------------------------ //

  RxString beforeImagePath = defaultImageStr.obs;
  RxString afterImagePath = defaultImageStr.obs;

  Future<void> loadImagesFromApplicationFolder() async {
    final _prefs = await prefs;
    String? beforeImageSavedPath = _prefs.getString(beforeImagePrefKey);
    if (beforeImageSavedPath != null) {
      beforeImagePath.value = beforeImageSavedPath;
    }

    String? afterImageSavedPath = _prefs.getString(afterImagePrefKey);
    if (afterImageSavedPath != null) {
      afterImagePath.value = afterImageSavedPath;
    }
  }

  Future<File> saveImagesToApplicationFolder(
      String prefKey, File imageFile) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;

    final fileName = basename(imageFile.path);
    final File localFile = await imageFile.copy('$appDocPath/$fileName');

    final _prefs = await prefs;
    await _prefs.setString(prefKey, localFile.path);

    return localFile;
  }

  Future<void> pickBeforeImage(File imageFile) async {
    beforeImagePath.value = imageFile.path;
    await saveImagesToApplicationFolder(beforeImagePrefKey, imageFile);
  }

  Future<void> pickAfterImage(File imageFile) async {
    afterImagePath.value = imageFile.path;
    await saveImagesToApplicationFolder(afterImagePrefKey, imageFile);
  }

  // ------------------------ Image Before - After ------------------------ //

  @override
  void onInit() async {
    super.onInit();
    await loadExerciseTracks();
    await loadNutritionTracks();
    await loadWaterTracks();
    await loadWeightTracks();
    await updateStepTrackData();
    await loadStepTracks();
    await loadImagesFromApplicationFolder();
  }
}
