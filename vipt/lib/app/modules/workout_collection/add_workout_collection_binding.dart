import 'package:get/get.dart';
import 'package:vipt/app/modules/workout_collection/add_workout_collection_controller.dart';

class AddWorkoutCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddWorkoutCollectionController());
  }
}
