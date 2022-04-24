import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/providers/meal_nutrition_track_provider.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyNutritionController extends GetxController with TrackerController {
  final _nutriTrackProvider = MealNutritionTrackProvider();
  final _exerciseTrackProvider = ExerciseTrackProvider();

  Rx<int> intakeCalo = 0.obs;
  Rx<int> outtakeCalo = 0.obs;
  Rx<int> diffCalo = 0.obs;
  Rx<int> carbs = 0.obs;
  Rx<int> protein = 0.obs;
  Rx<int> fat = 0.obs;

  List<Tracker> exerciseTracks = [];

  @override
  void onInit() {
    super.onInit();
    diffCalo.value = intakeCalo.value - outtakeCalo.value;
    // TODO: vấn đề hiển thị số âm
    fetchTracksByDate(DateTime.now());
  }

  @override
  fetchTracksByDate(DateTime date) async {
    this.date = date;
    tracks = await _nutriTrackProvider.fetchByDate(date);
    exerciseTracks = await _exerciseTrackProvider.fetchByDate(date);

    outtakeCalo.value = 0;
    exerciseTracks.map((e) {
      e as ExerciseTracker;
      outtakeCalo.value += e.outtakeCalories;
    }).toList();

    intakeCalo.value = 0;
    diffCalo.value = 0;
    carbs.value = 0;
    protein.value = 0;
    fat.value = 0;

    tracks.map((e) {
      e as MealNutritionTracker;
      carbs.value += e.carbs;
      protein.value += e.protein;
      fat.value += e.fat;
      intakeCalo.value += e.intakeCalories;
    }).toList();

    diffCalo.value = intakeCalo.value - outtakeCalo.value;
  }

  addTracks(
      {int intakeCalo = 0,
      int carbs = 0,
      int protein = 0,
      int fat = 0,
      required String name}) async {
    this.carbs.value += carbs;
    this.protein.value += protein;
    this.fat.value += fat;
    this.intakeCalo.value += intakeCalo;
    diffCalo.value = this.intakeCalo.value - outtakeCalo.value;

    MealNutritionTracker tracker = MealNutritionTracker(
        date: DateUtils.isSameDay(date, DateTime.now()) ? DateTime.now() : date,
        name: name,
        intakeCalories: intakeCalo,
        carbs: carbs,
        protein: protein,
        fat: fat);
    tracks.add(tracker);
    await _nutriTrackProvider.add(tracker);
    update();
  }

  deleteTrack(MealNutritionTracker tracker) async {
    carbs.value -= tracker.carbs;
    protein.value -= tracker.protein;
    fat.value -= tracker.fat;
    intakeCalo.value -= tracker.intakeCalories;
    diffCalo.value = intakeCalo.value - outtakeCalo.value;
    tracks.remove(tracker);
    await _nutriTrackProvider.delete(tracker.id ?? 0);
    update();
  }
}
