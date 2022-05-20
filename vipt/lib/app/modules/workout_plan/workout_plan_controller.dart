import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/weight_tracker.dart';
import 'package:vipt/app/data/models/workout_plan.dart';
import 'package:vipt/app/data/models/workout_plan_exercise.dart';
import 'package:vipt/app/data/models/workout_plan_meal.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/providers/meal_nutrition_track_provider.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/providers/weight_tracker_provider.dart';
import 'package:vipt/app/data/providers/workout_plan_exercise_provider.dart';
import 'package:vipt/app/data/providers/workout_plan_meal_provider.dart';
import 'package:vipt/app/data/providers/workout_plan_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/enums/app_enums.dart';

class WorkoutPlanController extends GetxController {
  static const num defaultWeightValue = 0;
  static const WeightUnit defaultWeightUnit = WeightUnit.kg;
  static const int defaultCaloriesValue = 0;

  // --------------- LOG WEIGHT --------------------------------

  final _weighTrackProvider = WeightTrackerProvider();
  final _userProvider = UserProvider();
  Rx<num> currentWeight = defaultWeightValue.obs;
  Rx<num> goalWeight = defaultWeightValue.obs;
  WeightUnit weightUnit = defaultWeightUnit;

  String get unit => weightUnit == WeightUnit.kg ? 'kg' : 'lbs';

  Future<void> loadWeightValues() async {
    final _userInfo = DataService.currentUser;
    if (_userInfo == null) {
      return;
    }

    currentWeight.value = _userInfo.currentWeight;
    goalWeight.value = _userInfo.goalWeight;
    weightUnit = _userInfo.weightUnit;
  }

  Future<void> logWeight(String newWeightStr) async {
    int newWeight = int.parse(newWeightStr);
    currentWeight.value = newWeight;

    await _weighTrackProvider
        .add(WeightTracker(date: DateTime.now(), weight: newWeight));

    final _userInfo = DataService.currentUser;
    if (_userInfo != null) {
      _userInfo.currentWeight = newWeight;
      await _userProvider.update(_userInfo.id ?? '', _userInfo);
    }
  }

  // --------------- LOG WEIGHT --------------------------------

  // --------------- WORKOUT + MEAL PLAN --------------------------------
  final _nutriTrackProvider = MealNutritionTrackProvider();
  final _exerciseTrackProvider = ExerciseTrackProvider();
  final _workoutPlanProvider = WorkoutPlanProvider();
  final _wkExerciseProvider = WorkoutPlanExerciseProvider();
  final _wkMealProvider = WorkoutPlanMealProvider();

  RxInt intakeCalories = defaultCaloriesValue.obs;
  RxInt outtakeCalories = defaultCaloriesValue.obs;
  RxInt get dailyDiffCalories =>
      (intakeCalories.value - outtakeCalories.value).obs;
  RxInt dailyGoalCalories = defaultCaloriesValue.obs;
  RxList<WorkoutPlanExercise> wpExerciseList = <WorkoutPlanExercise>[].obs;
  RxList<WorkoutPlanMeal> wpMealList = <WorkoutPlanMeal>[].obs;

  Future<void> loadDailyGoalCalories() async {
    List<WorkoutPlan> list = await _workoutPlanProvider.fetchAll();
    if (list.isNotEmpty) {
      dailyGoalCalories.value = list[0].dailyGoalCalories.toInt();
    }
  }

  Future<void> loadWorkoutPlanExerciseList() async {
    List<WorkoutPlanExercise> list = await _wkExerciseProvider.fetchAll();
    if (list.isNotEmpty) {
      wpExerciseList.value = list;
    }
  }

  Future<void> loadWorkoutPlanMealList() async {
    List<WorkoutPlanMeal> list = await _wkMealProvider.fetchAll();
    if (list.isNotEmpty) {
      wpMealList.value = list;
    }
  }

  Future<void> loadDailyCalories() async {
    final date = DateTime.now();
    final List<MealNutritionTracker> tracks =
        await _nutriTrackProvider.fetchByDate(date);
    final List<ExerciseTracker> exerciseTracks =
        await _exerciseTrackProvider.fetchByDate(date);

    outtakeCalories.value = 0;
    exerciseTracks.map((e) {
      outtakeCalories.value += e.outtakeCalories;
    }).toList();

    intakeCalories.value = 0;
    dailyDiffCalories.value = 0;

    tracks.map((e) {
      intakeCalories.value += e.intakeCalories;
    }).toList();

    dailyDiffCalories.value = intakeCalories.value - outtakeCalories.value;
  }

  // --------------- WORKOUT + MEAL PLAN --------------------------------

  @override
  void onInit() async {
    super.onInit();
    await loadWeightValues();
    await loadDailyCalories();
    await loadDailyGoalCalories();
    await loadWorkoutPlanExerciseList();
    await loadWorkoutPlanMealList();
  }
}
