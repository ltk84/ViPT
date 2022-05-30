import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppDecoration {
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(24, 24, 24, 24);
  static InputDecoration noHighlightInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
  );
  // static InputDecoration fillInputDecoration = InputDecoration(
  //   filled: true,
  //   fillColor: AppColor.textFieldFill,
  //   border: const OutlineInputBorder(
  //       borderSide: BorderSide.none,
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(28),
  //         bottomLeft: Radius.circular(28),
  //         bottomRight: Radius.circular(28),
  //       )),
  // );
  // static InputDecoration dateTimeFieldDecoration = InputDecoration(
  //   filled: true,
  //   suffixIcon: const Icon(
  //     Icons.calendar_today_rounded,
  //     size: 18,
  //   ),
  //   fillColor: AppColor.textFieldFill,
  //   border: const OutlineInputBorder(
  //     borderSide: BorderSide.none,
  //     borderRadius: BorderRadius.only(
  //       topLeft: Radius.circular(10),
  //       topRight: Radius.circular(28),
  //       bottomLeft: Radius.circular(28),
  //       bottomRight: Radius.circular(10),
  //     ),
  //   ),
  // );
}

class AppValue {
  // firestore
  // authentication
  static const usersPath = 'users';

  // workout module
  static const workoutsPath = 'workouts';
  static const workoutCategoriesPath = 'workoutCategories';

  // workout collection module
  static const workoutCollectionCategoriesPath = 'workoutCollectionCategories';
  static const workoutEquipmentCollectionPath = 'workoutEquipment';
  static const workoutCollectionsPath = 'workoutCollections';
  static const userCollectionsPath = 'userCollections';
  static const collectionOfSingleUserPath = 'collections';
  static const equipmentCollectionPath = 'equipment';

  // meal module
  static const mealIngredientsPath = 'mealIngredients';
  static const mealsPath = 'meals';
  static const mealCategories = 'mealCategories';

  // meal collection module
  static const mealCollections = 'mealCollections';

  // storage
  static const workoutsStorageCollectionPath = 'workouts';
  static const workoutsThumbStorageCollectionPath = 'thumbnails';
  static const workoutsAnimationStorageCollectionPath = 'animations';
  static const workoutsMuscleFocusStorageCollectionPath = 'muscle_focus';
  static const workoutCollectionsStorageCollectionPath = 'workoutCollections';
  static const categoriesCollectionsStorageCollectionPath = 'categories';
  static const collectioncategoriesCollectionsStorageCollectionPath =
      'collectionCategories';
  static const equipmentStorageCollectionPath = 'equipment';

  // sqflite
  static const waterTrackTable = 'WaterTrackRecord';
  static const exerciseTrackTable = 'ExerciseTrackRecord';
  static const mealNutritionTrackTable = 'MealNutriTrackRecord';
  static const localMealTable = 'LocalMeal';
  static const weightTrackTable = 'WeightTrackRecord';
  static const stepTrackTable = 'StepTrackRecord';
  static const workoutPlanTable = 'WorkoutPlanRecord';
  static const planExerciseCollectionTable = 'PlanExerciseCollectionRecord';
  static const planExerciseCollectionSettingTable =
      'PlanExerciseCollectionSettingRecord';
  static const planExerciseTable = 'PlanExerciseRecord';
  static const planMealCollectionTable = 'PlanMealCollectionRecord';
  static const planMealTable = 'PlanMealRecord';

  // other
  static const intensityWeight = 500;
  static const intensityWeightPerWeek = 0.5;

  // limit
  static const heightCeilInCmValue = 90;
  static const heightFloorInCmValue = 300;
  static const weightCeilInKgValue = 25;
  static const weightFloorInKgvalue = 300;

  static const heightCeilInFtValue = 2.95275591;
  static const heightFloorInFtValue = 9.84251969;
  static const weightCeilInLbsValue = 55.1155655;
  static const weightFloorInLbsValue = 661.386787;
}
