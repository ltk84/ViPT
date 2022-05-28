import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/plan_exercise.dart';
import 'package:vipt/app/data/models/plan_exercise_collection_setting.dart';
import 'package:vipt/app/data/models/plan_meal.dart';
import 'package:vipt/app/data/models/plan_meal_collection.dart';
import 'package:vipt/app/data/models/weight_tracker.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/models/workout_plan.dart';
import 'package:vipt/app/data/models/plan_exercise_collection.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/providers/meal_nutrition_track_provider.dart';
import 'package:vipt/app/data/providers/meal_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_collection_setting_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_provider.dart';
import 'package:vipt/app/data/providers/plan_meal_collection_provider.dart';
import 'package:vipt/app/data/providers/plan_meal_provider.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/providers/weight_tracker_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_collection_provider.dart';
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

    _markRelevantTabToUpdate();
  }

  // --------------- LOG WEIGHT --------------------------------

  // --------------- WORKOUT + MEAL PLAN --------------------------------
  final _nutriTrackProvider = MealNutritionTrackProvider();
  final _exerciseTrackProvider = ExerciseTrackProvider();
  final _workoutPlanProvider = WorkoutPlanProvider();
  final _wkExerciseCollectionProvider = PlanExerciseCollectionProvider();
  final _wkExerciseProvider = PlanExerciseProvider();
  final _colSettingProvider = PlanExerciseCollectionSettingProvider();
  final _wkMealCollectionProvider = PlanMealCollectionProvider();
  final _wkMealProvider = PlanMealProvider();

  RxBool isLoading = false.obs;
  RxBool isMealListLoading = false.obs;

  RxInt intakeCalories = defaultCaloriesValue.obs;
  RxInt outtakeCalories = defaultCaloriesValue.obs;
  RxInt get dailyDiffCalories =>
      (intakeCalories.value - outtakeCalories.value).obs;
  RxInt dailyGoalCalories = defaultCaloriesValue.obs;

  List<PlanExerciseCollection> planExerciseCollection =
      <PlanExerciseCollection>[];
  List<PlanExercise> planExercise = <PlanExercise>[];
  List<PlanExerciseCollectionSetting> collectionSetting =
      <PlanExerciseCollectionSetting>[];

  List<PlanMealCollection> planMealCollection = <PlanMealCollection>[];
  List<PlanMeal> planMeal = [];

  Future<void> loadDailyGoalCalories() async {
    List<WorkoutPlan> list = await _workoutPlanProvider.fetchAll();
    if (list.isNotEmpty) {
      dailyGoalCalories.value = list[0].dailyGoalCalories.toInt();
    }
  }

  Future<void> loadPlanExerciseCollectionList() async {
    List<PlanExerciseCollection> list =
        await _wkExerciseCollectionProvider.fetchAll();
    if (list.isNotEmpty) {
      planExerciseCollection = list;
      await loadCollectionSetting();
      await loadPlanExerciseList();
    }
  }

  Future<void> loadPlanExerciseList() async {
    List<PlanExercise> _list = await _wkExerciseProvider.fetchAll();
    if (_list.isNotEmpty) {
      planExercise = _list;
    }
  }

  Future<void> loadCollectionSetting() async {
    var _list = await _colSettingProvider.fetchAll();
    if (_list.isNotEmpty) {
      collectionSetting = _list;
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

  List<WorkoutCollection> loadWorkoutCollectionToShow(DateTime date) {
    var collection = planExerciseCollection
        .where((element) => DateUtils.isSameDay(element.date, date))
        .toList();

    if (collection.isNotEmpty) {
      return collection.map((col) {
        List<PlanExercise> exerciseList =
            planExercise.where((p0) => p0.listID == col.id).toList();
        return WorkoutCollection(col.id.toString(),
            title:
                'Bat tap ${col.id} (${col.date.day}/${col.date.month}/${col.date.year})',
            description: '',
            asset: '',
            generatorIDs: exerciseList.map((e) => e.exerciseID).toList(),
            categoryIDs: []);
      }).toList();
    }
    return <WorkoutCollection>[];
  }

  CollectionSetting? getCollectionSetting(String workoutCollectionID) {
    PlanExerciseCollection? selected = planExerciseCollection
        .firstWhereOrNull((p0) => p0.id.toString() == workoutCollectionID);
    if (selected != null) {
      PlanExerciseCollectionSetting? setting =
          collectionSetting.firstWhereOrNull(
              (element) => element.id == selected.collectionSettingID);
      return setting;
    }
    return null;
  }

  Future<void> loadWorkoutPlanMealList() async {
    List<PlanMealCollection> list = await _wkMealCollectionProvider.fetchAll();
    if (list.isNotEmpty) {
      planMealCollection = list;
      await loadPlanMealList();
    }
  }

  Future<void> loadPlanMealList() async {
    List<PlanMeal> _list = await _wkMealProvider.fetchAll();
    if (_list.isNotEmpty) {
      planMeal = _list;
    }
  }

  Future<List<Meal>> loadMealListToShow(DateTime date) async {
    isMealListLoading.value = true;
    final firebaseMealProvider = MealProvider();
    var collection = planMealCollection
        .where((element) => DateUtils.isSameDay(element.date, date));
    if (collection.isEmpty) {
      return [];
    } else {
      List<PlanMeal> _list = planMeal
          .where((element) => element.listID == collection.first.id)
          .toList();
      List<Meal> mealList = [];
      for (var element in _list) {
        var m = await firebaseMealProvider.fetch(element.mealID);
        mealList.add(m);
      }

      isMealListLoading.value = false;
      return mealList;
    }
  }

  // --------------- WORKOUT + MEAL PLAN --------------------------------

  // --------------- STREAK --------------------------------
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<bool> planStreak = [];

  Future<void> loadPlanStreak() async {
    List<WorkoutPlan> list = await _workoutPlanProvider.fetchAll();
    if (list.isNotEmpty) {
      var plan = list[0];
      int dateExtend = plan.endDate.difference(plan.startDate).inDays;
      List<bool> streak = [];
      final _prefs = await prefs;
      for (int i = 0; i < dateExtend; i++) {
        DateTime date = plan.startDate.add(Duration(days: i));
        var res = _prefs.getBool(DateUtils.dateOnly(date).toString());
        if (res != null) {
          streak.add(res);
        } else {
          // TODO: làm thông báo không tìm được streak list
          printError(info: 'Loi khong tim streak vao date $date');
          return;
        }
      }

      planStreak.clear();
      planStreak.addAll(streak);
    }
  }

  // --------------- STREAK --------------------------------

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await loadWeightValues();
    await loadDailyCalories();
    await loadDailyGoalCalories();
    await loadPlanExerciseCollectionList();
    await loadWorkoutPlanMealList();
    await loadPlanStreak();
    isLoading.value = false;

    ever(dailyDiffCalories, (_) async {
      if (dailyDiffCalories.value >= dailyGoalCalories.value) {
        final _prefs = await prefs;
        DateTime date = DateUtils.dateOnly(DateTime.now());
        bool? isTodayComplete = _prefs.getBool(date.toString());
        if (isTodayComplete == null) {
          // TODO: làm thông báo không tìm được streak list
          printError(info: 'Loi khong tim streak vao date $date');
          return;
        }
        _prefs.setBool(date.toString(), true);
      }
    });
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }
  }
}
