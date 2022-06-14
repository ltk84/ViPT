import 'package:get/get.dart';
import 'package:vipt/app/data/models/local_meal_nutrition.dart';
import 'package:vipt/app/data/providers/local_meal_provider.dart';

class AddLocalMealController extends GetxController {
  final _provider = LocalMealProvider();

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

  addLocalMeal() async {
    if (name.isNotEmpty && isTextFieldValidate.value) {
      LocalMealNutrition localMeal = LocalMealNutrition(
          name: name,
          calories: calories.value,
          carbs: carbs.value,
          fat: fat.value,
          protein: protein.value);
      await _provider.add(localMeal);
      reseteScreen();
    }
  }
}
