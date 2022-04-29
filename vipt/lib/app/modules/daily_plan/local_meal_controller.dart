import 'package:get/get.dart';

class LocalMealController extends GetxController {
  String name = '';
  Rx<int> calories = 1.obs;
  Rx<int> carbs = 1.obs;
  Rx<int> protein = 1.obs;
  Rx<int> fat = 1.obs;

  Rx<bool> isTextFieldValidate = true.obs;

  addLocalMeal() {
    print('$name $calories $carbs $protein $fat');
  }

  editLocalMeal() {}
  deleteLocalMeal() {}
}
