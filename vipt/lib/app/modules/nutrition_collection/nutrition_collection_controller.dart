import 'package:get/get.dart';
import 'package:vipt/app/data/fake_data.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/data/providers/meal_provider.dart';

class NutritionCollectionController extends GetxController {
  List<MealCollection> mealCollectionList = mealCollectionFakeData;
  // meal list cua collection dang duoc chon
  List<MealNutrition> currentMealList = [];

  late MealCollection currentCollection;

  setCurrentCollection(MealCollection mealCollection) {
    currentCollection = mealCollection;
  }

  calculateTotalCalo() {}

  fetchMealNutritionList() async {
    currentMealList.clear();
    final mealProvider = MealProvider();
    for (var element in currentCollection.dateToMealID.entries) {
      for (var mealID in element.value) {
        final meal = await mealProvider.fetch(mealID);
        final mealNutri = MealNutrition(meal: meal);
        mealNutri.getIngredients();
        currentMealList.add(mealNutri);
      }
    }
  }

  getMealListByDay(int dayId) {
    List<Meal> mealList = [];
    for (var item in currentMealList) {
      if (currentCollection.dateToMealID[dayId]!.contains(item.meal.id) ==
          true) {
        mealList.add(item.meal);
      }
    }
    return mealList;
  }
}
