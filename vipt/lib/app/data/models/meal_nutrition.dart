import 'package:vipt/app/data/models/ingredient.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_nutrition_tracker.dart';
import 'package:vipt/app/data/models/nutrition.dart';
import 'package:vipt/app/data/models/tracker.dart';
import 'package:vipt/app/data/providers/ingredient_provider.dart';
import 'package:vipt/app/data/providers/meal_category_provider.dart';

class MealNutrition extends Nutrition {
  final Meal meal;
  late final List<String> mealCate;
  MealNutrition({String? id, required this.meal}) : super(id);

  List<Ingredient> ingredients = [];

  Future<void> getIngredients() async {
    ingredients.clear();
    final _ingrProvider = IngredientProvider();
    for (var id in meal.ingreIDToAmount.keys.toList()) {
      var e = await _ingrProvider.fetch(id);
      ingredients.add(e);
    }

    await fetchCategory();
    initNutrition();
  }

  fetchCategory() async {
    mealCate = [];
    for (var cateID in meal.categoryIDs) {
      final cate = await MealCategoryProvider().fetch(cateID);
      mealCate.add(cate.name);
    }
  }

  String getMealCate() {
    String result = mealCate.toString();
    result = result.substring(1, result.length - 1);
    return result;
  }

  void resetNutrition() {
    calories = 0;
    carbs = 0;
    fat = 0;
    protein = 0;
  }

  void initNutrition() {
    resetNutrition();
    for (var ingre in ingredients) {
      RegExp reg = RegExp(r'\d[A-Za-z]');
      var regMatch = reg.firstMatch(meal.ingreIDToAmount[ingre.id] ?? '');
      if (regMatch != null) {
        int pos = regMatch.start;
        final amount =
            num.parse(meal.ingreIDToAmount[ingre.id]!.substring(0, pos + 1));
        calories += (ingre.kcal * amount / 100);
        carbs += (ingre.carbs * amount / 100);
        fat += (ingre.fat * amount / 100);
        protein += (ingre.protein * amount / 100);
      }
    }
  }

  @override
  String getName() {
    return meal.name;
  }

  @override
  Tracker convertToMealNutritionTracker() {
    return MealNutritionTracker(
        date: DateTime.now(),
        name: meal.name,
        intakeCalories: calories.toInt(),
        carbs: carbs.toInt(),
        protein: protein.toInt(),
        fat: fat.toInt());
  }
}
