import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/data/models/plan_exercise.dart';
import 'package:vipt/app/data/models/plan_exercise_collection.dart';
import 'package:vipt/app/data/models/plan_exercise_collection_setting.dart';
import 'package:vipt/app/data/models/plan_meal.dart';
import 'package:vipt/app/data/models/plan_meal_collection.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_plan.dart';
import 'package:vipt/app/data/providers/plan_exercise_collection_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_collection_setting_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_provider.dart';
import 'package:vipt/app/data/providers/plan_meal_collection_provider.dart';
import 'package:vipt/app/data/providers/plan_meal_provider.dart';
import 'package:vipt/app/data/providers/workout_plan_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';

class ExerciseNutritionRouteProvider {
  Future<void> createRoute(ViPTUser user) async {
    final _workoutPlanProvider = WorkoutPlanProvider();
    num weightDiff = user.goalWeight - user.currentWeight;
    num workoutPlanLengthInWeek =
        weightDiff.abs() / AppValue.intensityWeightPerWeek;
    int workoutPlanLengthInDays = workoutPlanLengthInWeek.toInt() * 7;

    DateTime workoutPlanStartDate = DateTime.now();
    DateTime workoutPlanEndDate =
        DateTime.now().add(Duration(days: workoutPlanLengthInDays));

    num dailyGoalCalories = WorkoutPlanUtils.createDailyGoalCalories(user);
    num dailyIntakeCalories = dailyGoalCalories + AppValue.intensityWeight;
    num dailyOuttakeCalories = AppValue.intensityWeight;

    final WorkoutPlan workoutPlan = WorkoutPlan(
        dailyGoalCalories: dailyGoalCalories,
        startDate: workoutPlanStartDate,
        endDate: workoutPlanEndDate);
    _workoutPlanProvider.add(workoutPlan);

    await _generateMealListWithPlanLength(
        intakeCalories: dailyIntakeCalories,
        planLength: workoutPlanLengthInDays);

    await generateExerciseListWithPlanLength(
        dailyOuttakeCalories, user.currentWeight, workoutPlanLengthInDays);

    await _generateInitialPlanStreak(
        startDate: workoutPlanStartDate,
        planLengthInDays: workoutPlanLengthInDays);
  }

  Future<void> generateExerciseListWithPlanLength(
      num outtakeCalories, num userWeight, int workoutPlanLength) async {
    for (int i = 0; i < workoutPlanLength; i++) {
      await _generateExerciseListEveryDay(
          outtakeCalories: outtakeCalories,
          userWeight: userWeight,
          date: DateTime.now().add(Duration(days: i)));
    }
  }

  Future<void> _generateExerciseListEveryDay(
      {required num outtakeCalories,
      required num userWeight,
      required DateTime date}) async {
    int numberOfExercise = 10;
    int everyExerciseSeconds = 45;
    List<Workout> exerciseList1 = _randomExercises(numberOfExercise);
    List<Workout> exerciseList2 = _randomExercises(numberOfExercise);

    double totalCalo1 = 0;
    for (var element in exerciseList1) {
      double calo = SessionUtils.calculateCaloOneWorkout(
          everyExerciseSeconds, element.metValue, userWeight);
      totalCalo1 += calo;
    }

    double totalCalo2 = 0;
    for (var element in exerciseList2) {
      double calo = SessionUtils.calculateCaloOneWorkout(
          everyExerciseSeconds, element.metValue, userWeight);
      totalCalo2 += calo;
    }

    int round1 = ((outtakeCalories / 2) / totalCalo1).ceil();
    int round2 = ((outtakeCalories / 2) / totalCalo2).ceil();

    //  tao collection setting
    PlanExerciseCollectionSetting setting1 = PlanExerciseCollectionSetting(
        round: round1,
        exerciseTime: everyExerciseSeconds,
        numOfWorkoutPerRound: numberOfExercise);

    PlanExerciseCollectionSetting setting2 = PlanExerciseCollectionSetting(
        round: round2,
        exerciseTime: everyExerciseSeconds,
        numOfWorkoutPerRound: numberOfExercise);

    final _settingProvider = PlanExerciseCollectionSettingProvider();
    setting1 = (await _settingProvider.add(setting1));
    setting2 = (await _settingProvider.add(setting2));

    PlanExerciseCollection collection1 = PlanExerciseCollection(
        date: date, collectionSettingID: setting1.id ?? 0);

    PlanExerciseCollection collection2 = PlanExerciseCollection(
        date: date, collectionSettingID: setting2.id ?? 0);

    final _collectionProvider = PlanExerciseCollectionProvider();
    collection1 = (await _collectionProvider.add(collection1));
    collection2 = (await _collectionProvider.add(collection2));

    final _exerciseProvider = PlanExerciseProvider();
    for (var element in exerciseList1) {
      PlanExercise pe = PlanExercise(
          exerciseID: element.id ?? '', listID: collection1.id ?? 0);
      _exerciseProvider.add(pe);
    }

    for (var element in exerciseList2) {
      PlanExercise pe = PlanExercise(
          exerciseID: element.id ?? '', listID: collection2.id ?? 0);
      _exerciseProvider.add(pe);
    }
  }

  List<Workout> _randomExercises(int numberOfExercise) {
    int count = 0;
    final _random = Random();
    List<Workout> result = [];
    final allExerciseList = DataService.instance.workoutList;
    while (count < numberOfExercise) {
      var element = allExerciseList[_random.nextInt(allExerciseList.length)];
      if (!result.contains(element)) {
        result.add(element);
        count++;
      }
    }

    return result;
  }

  Future<void> _generateMealListWithPlanLength(
      {required num intakeCalories, required int planLength}) async {
    for (int i = 0; i < planLength; i++) {
      _generateMealList(
          intakeCalories: intakeCalories,
          date: DateTime.now().add(Duration(days: i)));
    }
  }

  Future<void> _generateMealList(
      {required num intakeCalories, required DateTime date}) async {
    List<Meal> mealList = await _randomMeals();
    num ratio = await _calculateMealRatio(intakeCalories, mealList);

    PlanMealCollection collection =
        PlanMealCollection(date: date, mealRatio: ratio.toDouble());
    collection = (await PlanMealCollectionProvider().add(collection));

    final mealProvider = PlanMealProvider();
    for (var e in mealList) {
      PlanMeal meal = PlanMeal(mealID: e.id ?? '', listID: collection.id ?? 0);
      await mealProvider.add(meal);
    }
  }

  Future<double> _calculateMealRatio(
      num intakeCalories, List<Meal> mealList) async {
    num totalCalories = 0;
    for (var element in mealList) {
      var mealNutri = MealNutrition(meal: element);
      await mealNutri.getIngredients();
      totalCalories += mealNutri.calories;
    }

    return intakeCalories / totalCalories;
  }

  Future<List<Meal>> _randomMeals() async {
    List<Meal> result = [];
    final _random = Random();

    List<String> mealCategoryIDs =
        DataService.instance.mealCategoryList.map((e) => e.id ?? '').toList();

    final breakfastList = DataService.instance.mealList
        .where((element) => element.categoryIDs.contains(mealCategoryIDs[0]))
        .toList();
    final lunchDinnerList = DataService.instance.mealList
        .where((element) => element.categoryIDs.contains(mealCategoryIDs[1]))
        .toList();
    final snackList = DataService.instance.mealList
        .where((element) => element.categoryIDs.contains(mealCategoryIDs[2]))
        .toList();

    var breakfastMeal = breakfastList[_random.nextInt(breakfastList.length)];
    if (!result.contains(breakfastMeal)) {
      result.add(breakfastMeal);
    }

    var lunchDinnerMeal =
        lunchDinnerList[_random.nextInt(lunchDinnerList.length)];
    if (!result.contains(lunchDinnerMeal)) {
      result.add(lunchDinnerMeal);
    }

    var snackMeal = snackList[_random.nextInt(snackList.length)];
    if (!result.contains(snackMeal)) {
      result.add(snackMeal);
    }
    return result;
  }

  Future<void> _generateInitialPlanStreak(
      {required DateTime startDate, required int planLengthInDays}) async {
    final _prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < planLengthInDays; i++) {
      DateTime date = DateUtils.dateOnly(startDate.add(Duration(days: i)));
      _prefs.setBool(date.toString(), false);
    }
  }

  Future<Map<int, List<bool>>> loadStreakList() async {
    int currentStreakDay = 0;
    List<WorkoutPlan> list = await WorkoutPlanProvider().fetchAll();
    if (list.isNotEmpty) {
      var plan = list[0];
      int dateExtend = plan.endDate.difference(plan.startDate).inDays;
      List<bool> streak = [];
      final _prefs = await SharedPreferences.getInstance();
      for (int i = 0; i < dateExtend; i++) {
        DateTime date = plan.startDate.add(Duration(days: i));

        if (DateUtils.isSameDay(date, DateTime.now())) {
          currentStreakDay = i + 1;
        }

        var res = _prefs.getBool(DateUtils.dateOnly(date).toString());
        if (res != null) {
          streak.add(res);
        } else {
          return <int, List<bool>>{};
        }
      }

      Map<int, List<bool>> map =
          {currentStreakDay, streak} as Map<int, List<bool>>;
      return map;
    }

    return <int, List<bool>>{};
  }

  Future<void> deleteRoute() async {
    await _deleteStreakList();
    await _deletePlanMealList();
    await _deletePlanExerciseList();
    await _deleteWorkoutPlanList();
  }

  Future<void> _deleteStreakList() async {
    final _prefs = await SharedPreferences.getInstance();
    // _prefs.remove(key)
  }

  Future<void> _deletePlanMealList() async {}

  Future<void> _deletePlanExerciseList() async {}

  Future<void> _deleteWorkoutPlanList() async {}
}
