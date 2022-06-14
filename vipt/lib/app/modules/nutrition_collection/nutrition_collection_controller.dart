import 'package:get/get.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/data/providers/meal_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';

class NutritionCollectionController extends GetxController {
  List<MealCollection> mealCollectionList =
      DataService.instance.mealCollectionList;
  // meal list cua collection dang duoc chon
  List<MealNutrition> currentMealList = [];

  late MealCollection currentCollection;

  num averageCalories = 0;
  num averageCarbs = 0;
  num averageProtein = 0;
  num averageFat = 0;

  setCurrentCollection(MealCollection mealCollection) {
    currentCollection = mealCollection;
  }

  initNutritionInfor() {
    averageCalories = 0;
    averageCarbs = 0;
    averageProtein = 0;
    averageFat = 0;
  }

  calculateNutritionInfor() {
    initNutritionInfor();
    for (var meal in currentMealList) {
      averageCalories += meal.calories;
      averageCarbs += meal.carbs;
      averageProtein += meal.protein;
      averageFat += meal.fat;
    }

    averageCalories /= currentCollection.dateToMealID.length;
    averageCarbs /= currentCollection.dateToMealID.length;
    averageProtein /= currentCollection.dateToMealID.length;
    averageFat /= currentCollection.dateToMealID.length;
  }

  fetchMealNutritionList() async {
    currentMealList.clear();
    final mealProvider = MealProvider();
    for (var element in currentCollection.dateToMealID.entries) {
      for (var mealID in element.value) {
        final meal = await mealProvider.fetch(mealID);
        final mealNutri = MealNutrition(meal: meal);
        await mealNutri.getIngredients();
        currentMealList.add(mealNutri);
      }
    }
  }

  getMealListByDay(String dayId) {
    return currentMealList
        .where((element) =>
            currentCollection.dateToMealID[dayId]!.contains(element.meal.id) ==
            true)
        .toList();
  }
}
