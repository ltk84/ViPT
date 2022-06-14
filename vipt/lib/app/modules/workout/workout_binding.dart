import 'package:get/get.dart';
import 'package:vipt/app/modules/workout/workout_controller.dart';

class WorkoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WorkoutController());
  }
}
