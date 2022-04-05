import 'package:get/get.dart';
import 'package:vipt/app/modules/nutrition_collection/nutrition_collection_controller.dart';

class NutritionCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NutritionCollectionController());
  }
}
