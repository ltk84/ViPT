import 'package:get/get.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class WorkoutCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutCollectionController());
  }
}
