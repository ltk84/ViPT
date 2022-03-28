import 'package:vipt/app/data/models/ingredient.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/providers/ingredient_provider.dart';

class MealNutrition {
  final Meal meal;
  MealNutrition({required this.meal});

  num calories = 1;
  num carbs = 0;
  num fat = 0;
  num protein = 0;
  List<Ingredient> ingredients = [];

  getIngredients() async {
    final _ingrProvider = IngredientProvider();
    for (var id in meal.ingreIDToAmount.keys.toList()) {
      var e = await _ingrProvider.fetch(id);
      ingredients.add(e);
    }
  }

  void initNutrition() {
    for (var ingre in ingredients) {
      final amount = int.parse(meal.ingreIDToAmount[ingre.id]!.split(' ')[0]);
      print(amount);
      calories += (ingre.kcal * amount);
      carbs += (ingre.carbs * amount);
      fat += (ingre.fat * amount);
      protein += (ingre.protein * amount);
    }
  }
}
