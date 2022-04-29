import 'package:get/get.dart';
import 'package:vipt/app/data/models/local_meal_nutrition.dart';
import 'package:vipt/app/data/providers/local_meal_provider.dart';

class EditDeleteLocalMealController extends GetxController {
  final _provider = LocalMealProvider();

  String id = '';
  String name = '';
  Rx<int> calories = 1.obs;
  Rx<int> carbs = 1.obs;
  Rx<int> protein = 1.obs;
  Rx<int> fat = 1.obs;

  // biến validate dành cho text field
  // có giá trị ban đầu là true để tránh việc vừa hiển thị screen thì hiện validate.
  // nên để tránh lỗi thì ta sẽ check validate dựa trên biến name & biến này
  Rx<bool> isTextFieldValidate = true.obs;

  reseteScreen() {
    isTextFieldValidate.value = false;
  }

  setSelectedMeal(LocalMealNutrition meal) {
    id = meal.id!;
    name = meal.name;
    calories.value = meal.calories.toInt();
    carbs.value = meal.carbs.toInt();
    protein.value = meal.protein.toInt();
    fat.value = meal.fat.toInt();
  }

  editLocalMeal() async {
    if (name.isNotEmpty && isTextFieldValidate.value) {
      LocalMealNutrition localMeal = LocalMealNutrition(
          name: name,
          calories: calories.value,
          carbs: carbs.value,
          fat: fat.value,
          protein: protein.value);
      await _provider.update(int.parse(id), localMeal);
      reseteScreen();
    }
  }

  deleteLocalMeal() async {
    await _provider.delete(int.parse(id));
    reseteScreen();
  }
}
