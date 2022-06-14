import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
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
import 'package:vipt/app/data/providers/exercise_nutrition_route_provider.dart';
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
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/routes/pages.dart';

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
    int? newWeight = int.tryParse(newWeightStr);
    if (newWeight == null) {
      await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
            icon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(Icons.error_rounded,
                  color: AppColor.errorColor, size: 48),
            ),
            label: 'Đã xảy ra lỗi',
            content: 'Giá trị cân nặng không đúng định dạng',
            showOkButton: false,
            labelCancel: 'Đóng',
            onCancel: () {
              Navigator.of(context).pop();
            },
            buttonsAlignment: MainAxisAlignment.center,
            buttonFactorOnMaxWidth: double.infinity,
          );
        },
      );
      return;
    }

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

  WorkoutPlan? currentWorkoutPlan;

  RxBool isAllMealListLoading = false.obs;
  RxBool isTodayMealListLoading = false.obs;

  Future<void> loadDailyGoalCalories() async {
    WorkoutPlan? list = await _workoutPlanProvider
        .fetchByUserID(DataService.currentUser!.id ?? '');
    if (list != null) {
      currentWorkoutPlan = list;
      dailyGoalCalories.value = list.dailyGoalCalories.toInt();
    }
  }

  Future<void> loadPlanExerciseCollectionList(int planID) async {
    List<PlanExerciseCollection> list =
        await _wkExerciseCollectionProvider.fetchByPlanID(planID);
    if (list.isNotEmpty) {
      planExerciseCollection = list;

      planExercise.clear();
      collectionSetting.clear();

      for (int i = 0; i < list.length; i++) {
        await loadCollectionSetting(list[i].collectionSettingID);
        await loadPlanExerciseList(list[i].id ?? 0);
      }
    }
  }

  Future<void> loadPlanExerciseList(int listID) async {
    List<PlanExercise> _list = await _wkExerciseProvider.fetchByListID(listID);
    if (_list.isNotEmpty) {
      planExercise.addAll(_list);
    }
  }

  Future<void> loadCollectionSetting(int id) async {
    var _list = await _colSettingProvider.fetch(id);
    if (_list != null) {
      collectionSetting.add(_list);
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
    await _validateDailyCalories();
  }

  Future<void> _validateDailyCalories() async {
    String dateKey = DateUtils.dateOnly(DateTime.now()).toString();
    final _prefs = await prefs;
    bool? todayStreakValue = _prefs.getBool(dateKey);
    if (todayStreakValue == null) {
      await showNotFoundStreakDataDialog();
      return;
    }

    if (dailyDiffCalories.value >= dailyGoalCalories.value - 100 &&
        dailyDiffCalories.value <= dailyGoalCalories.value + 100) {
      if (!todayStreakValue) {
        await _prefs.setBool(
            DateUtils.dateOnly(DateTime.now()).toString(), true);
      }
    } else {
      if (todayStreakValue) {
        await _prefs.setBool(
            DateUtils.dateOnly(DateTime.now()).toString(), false);
      }
    }
  }

  List<WorkoutCollection> loadAllWorkoutCollection() {
    var collection = planExerciseCollection.toList();

    if (collection.isNotEmpty) {
      return collection.map((col) {
        List<PlanExercise> exerciseList =
            planExercise.where((p0) => p0.listID == col.id).toList();
        int index = collection.indexOf(col);
        return WorkoutCollection(col.id.toString(),
            title: 'Bài tập thứ ${index + 1}',
            description: '',
            asset: '',
            generatorIDs: exerciseList.map((e) => e.exerciseID).toList(),
            categoryIDs: []);
      }).toList();
    }
    return <WorkoutCollection>[];
  }

  List<WorkoutCollection> loadWorkoutCollectionToShow(DateTime date) {
    var collection = planExerciseCollection
        .where((element) => DateUtils.isSameDay(element.date, date))
        .toList();

    if (collection.isNotEmpty) {
      return collection.map((col) {
        List<PlanExercise> exerciseList =
            planExercise.where((p0) => p0.listID == col.id).toList();
        int index = collection.indexOf(col);

        return WorkoutCollection(col.id.toString(),
            title: 'Bài tập thứ ${index + 1}',
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

  Future<void> loadWorkoutPlanMealList(int planID) async {
    List<PlanMealCollection> list =
        await _wkMealCollectionProvider.fetchByPlanID(planID);
    if (list.isNotEmpty) {
      planMealCollection = list;

      planMeal.clear();

      for (int i = 0; i < list.length; i++) {
        await loadPlanMealList(list[i].id ?? 0);
      }
    }
  }

  Future<void> loadPlanMealList(int listID) async {
    List<PlanMeal> _list = await _wkMealProvider.fetchByListID(listID);
    if (_list.isNotEmpty) {
      planMeal.addAll(_list);
    }
  }

  Future<List<MealNutrition>> loadMealListToShow(DateTime date) async {
    isTodayMealListLoading.value = true;
    final firebaseMealProvider = MealProvider();
    var collection = planMealCollection
        .where((element) => DateUtils.isSameDay(element.date, date));
    if (collection.isEmpty) {
      isTodayMealListLoading.value = false;
      return [];
    } else {
      List<PlanMeal> _list = planMeal
          .where((element) => element.listID == collection.first.id)
          .toList();
      List<MealNutrition> mealList = [];
      for (var element in _list) {
        var m = await firebaseMealProvider.fetch(element.mealID);
        MealNutrition mn = MealNutrition(meal: m);
        await mn.getIngredients();
        mealList.add(mn);
      }

      isTodayMealListLoading.value = false;
      return mealList;
    }
  }

  Future<List<MealNutrition>> loadAllMealList() async {
    isAllMealListLoading.value = true;
    final firebaseMealProvider = MealProvider();
    var collection = planMealCollection;

    if (collection.isEmpty) {
      isAllMealListLoading.value = false;
      return [];
    } else {
      List<PlanMeal> _list = planMeal.toList();

      List<MealNutrition> mealList = [];
      for (var element in _list) {
        var m = await firebaseMealProvider.fetch(element.mealID);
        MealNutrition mn = MealNutrition(meal: m);
        await mn.getIngredients();
        mealList.add(mn);
      }

      isAllMealListLoading.value = false;
      return mealList;
    }
  }

  // --------------- WORKOUT + MEAL PLAN --------------------------------

  // --------------- STREAK --------------------------------
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<bool> planStreak = [];
  RxInt currentStreakDay = 0.obs;
  static const String planStatus = 'planStatus';

  final _routeProvider = ExerciseNutritionRouteProvider();

  Future<void> loadPlanStreak() async {
    planStreak.clear();

    // await Future.delayed(Duration(seconds: 1));

    Map<int, List<bool>> list = await _routeProvider.loadStreakList();
    if (list.isNotEmpty) {
      currentStreakDay.value = list.keys.first;

      final _prefs = await prefs;
      DateTime date = DateUtils.dateOnly(DateTime.now());
      if (dailyDiffCalories.value >= dailyGoalCalories.value - 100 &&
          dailyDiffCalories.value <= dailyGoalCalories.value + 100) {
        bool? isTodayComplete = _prefs.getBool(date.toString());
        if (isTodayComplete == null) {
          await showNotFoundStreakDataDialog();
          return;
        }
        await _prefs.setBool(date.toString(), true);
        list.values.first[currentStreakDay.value - 1] = true;
      } else {
        await _prefs.setBool(date.toString(), false);
        list.values.first[currentStreakDay.value - 1] = false;
      }

      planStreak.addAll(list.values.first);
    } else {
      await showNotFoundStreakDataDialog();
      return;
    }

    // Khi đã hoàn thành plan
    if (DateTime.now().isAfter(currentWorkoutPlan!.endDate)) {
      hasFinishedPlan.value = true;
      final _prefs = await prefs;
      _prefs.setBool(planStatus, true);

      await loadDataForFinishScreen();
      await Get.toNamed(Routes.finishPlanScreen);
    }
  }

  Future<void> loadPlanStatus() async {
    final _prefs = await prefs;
    hasFinishedPlan.value = _prefs.getBool(planStatus) ?? false;
  }

  Future<void> showNotFoundStreakDataDialog() async {
    await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          icon: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child:
                Icon(Icons.error_rounded, color: AppColor.errorColor, size: 48),
          ),
          label: 'Đã xảy ra lỗi',
          content: 'Không tìm thấy danh sách streak',
          showOkButton: false,
          labelCancel: 'Đóng',
          onCancel: () {
            Navigator.of(context).pop();
          },
          buttonsAlignment: MainAxisAlignment.center,
          buttonFactorOnMaxWidth: double.infinity,
        );
      },
    );
  }

  Future<void> resetStreakList() async {
    isLoading.value = true;
    await _routeProvider.resetRoute();
    isLoading.value = false;
  }

  // --------------- STREAK --------------------------------

  // --------------- FINISH WORKOUT PLAN--------------------------------
  static final DateTimeRange defaultWeightDateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  Rx<DateTimeRange> weightDateRange = defaultWeightDateRange.obs;
  RxList<WeightTracker> allWeightTracks = <WeightTracker>[].obs;
  final _weightProvider = WeightTrackerProvider();

  RxBool hasFinishedPlan = false.obs;

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
    weightDateRange.value = DateTimeRange(
        start: currentWorkoutPlan!.startDate, end: currentWorkoutPlan!.endDate);
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

  Future<void> loadDataForFinishScreen() async {
    await loadWeightTracks();
  }

  // --------------- FINISH WORKOUT PLAN --------------------------------

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await loadPlanStatus();
    await loadWeightValues();
    await loadDailyGoalCalories();
    await loadDailyCalories();
    await loadPlanExerciseCollectionList(currentWorkoutPlan!.id ?? 0);
    await loadWorkoutPlanMealList(currentWorkoutPlan!.id ?? 0);
    await loadPlanStreak();
    isLoading.value = false;
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }
  }
}
