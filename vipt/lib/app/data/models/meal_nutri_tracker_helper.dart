import 'package:vipt/app/data/models/meal.dart';

class MealNutriTrackerHelper {
  // TODO: thay doi thanh lay tu db sau
  List<Meal> userMeals = [];

  void addUserMeal(Meal meal) {
    userMeals.add(meal);
    updateToDB();
  }

  void updateUserMeal(Meal meal) {
    int index = userMeals.indexWhere((m) => m.id == meal.id);
    if (index >= 0) {
      userMeals[index] = meal;
      updateToDB();
    }
  }

  void deleteUserMeal(String id) {
    userMeals.removeWhere((element) => element.id == id);
    updateToDB();
  }

  void updateToDB() {}
}
