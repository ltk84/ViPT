import 'package:get/get.dart';
import 'package:vipt/app/modules/nutrition/nutrition_controller.dart';

class NutritionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NutritionController());
  }
}
