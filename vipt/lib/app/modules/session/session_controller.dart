import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class SessionController extends GetxController {
  WorkoutCollection currentCollection =
      Get.find<WorkoutCollectionController>().selectedCollection!;

  List<Workout> workoutList =
      Get.find<WorkoutCollectionController>().workoutList;
}
