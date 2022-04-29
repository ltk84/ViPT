import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/local_meal_nutrition.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/nutrition.dart';
import 'package:vipt/app/data/models/tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/providers/local_meal_provider.dart';
import 'package:vipt/app/data/providers/meal_nutrition_track_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyNutritionController extends GetxController with TrackerController {
  TextEditingController searchTextController = TextEditingController();

  final _nutriTrackProvider = MealNutritionTrackProvider();
  final _exerciseTrackProvider = ExerciseTrackProvider();
  final _localMealProvider = LocalMealProvider();

  List<MealNutrition> firebaseFoodList = [];
  RxList<MealNutrition> firebaseSearchResult = <MealNutrition>[].obs;
  List<LocalMealNutrition> localFoodList = [];
  RxList<LocalMealNutrition> localSearchResult = <LocalMealNutrition>[].obs;

  RxList<Nutrition> selectedList = <Nutrition>[].obs;

  Rx<int> intakeCalo = 0.obs;
  Rx<int> outtakeCalo = 0.obs;
  Rx<int> diffCalo = 0.obs;
  Rx<int> carbs = 0.obs;
  Rx<int> protein = 0.obs;
  Rx<int> fat = 0.obs;

  Rx<bool> finishFetchFoodList = false.obs;

  List<Tracker> exerciseTracks = [];

  TextEditingController firebaseListSearchController = TextEditingController();
  Rx<String> firebaseSearchText = ''.obs;
  TextEditingController localListSearchController = TextEditingController();
  Rx<String> localSearchText = ''.obs;

  Rx<int> activeTabIndex = 0.obs;

  @override
  void onInit() async {
    super.onInit();

    localFoodList = await _localMealProvider.fetchAll();

    await initFirebaseFoodList();

    diffCalo.value = intakeCalo.value - outtakeCalo.value;
    await fetchTracksByDate(DateTime.now());

    initDebounceForSearching();
  }

  initDebounceForSearching() {
    firebaseListSearchController.addListener(() {
      firebaseSearchText.value = firebaseListSearchController.text;
    });

    localListSearchController.addListener(() {
      localSearchText.value = localListSearchController.text;
    });

    debounce(firebaseSearchText, (_) {
      handleSearch(
          sourceList: firebaseFoodList,
          searchList: firebaseSearchResult,
          textController: firebaseListSearchController);
    }, time: const Duration(seconds: 1));

    debounce(localSearchText, (_) {
      handleSearch(
          sourceList: localFoodList,
          searchList: localSearchResult,
          textController: localListSearchController);
    }, time: const Duration(seconds: 1));
  }

  handleSearch(
      {required List<Nutrition> sourceList,
      required List<Nutrition> searchList,
      required TextEditingController textController}) {
    searchList.clear();
    var key = textController.text.toLowerCase();
    var temptList = sourceList
        .where((food) => food.getName().toLowerCase().contains(key))
        .toList();
    searchList.addAll(temptList);
  }

  void handleSelect(Nutrition nutrition) {
    if (selectedList.contains(nutrition)) {
      selectedList.remove(nutrition);
    } else {
      selectedList.add(nutrition);
    }
  }

  Future<void> initFirebaseFoodList() async {
    if (firebaseFoodList.isNotEmpty) firebaseFoodList.clear();
    firebaseFoodList = await Future.wait(
        List.generate(DataService.instance.mealList.length, (index) async {
      var meal = MealNutrition(meal: DataService.instance.mealList[index]);
      await meal.getIngredients();
      return meal;
    }));

    finishFetchFoodList.value = true;
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

  resetSelectedList() => selectedList.clear();

  handleLogTrack() async {
    for (var track in selectedList) {
      await addTrack(
          name: track.getName(),
          intakeCalo: track.calories.toInt(),
          carbs: track.carbs.toInt(),
          fat: track.fat.toInt(),
          protein: track.protein.toInt());
    }

    resetSelectedList();
    Get.back();
  }

  addTrack(
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
