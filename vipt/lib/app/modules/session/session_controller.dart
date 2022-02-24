import 'package:get/get.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class SessionController extends GetxController {
  WorkoutCollection currentCollection =
      Get.find<WorkoutCollectionController>().selectedCollection!;
  List<Workout> workoutList =
      Get.find<WorkoutCollectionController>().workoutList;
  Rx<int> workoutIndex = 0.obs;
  late Rx<Workout> currentWorkout;

  final timeValue = Get.find<WorkoutCollectionController>().timeValue.value;

  final collectionSetting =
      Get.find<WorkoutCollectionController>().collectionSetting.value;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    currentWorkout = workoutList[workoutIndex.value].obs;

    super.onInit();
  }

  void pause() {}

  void skip() {}

  void start() {}
}
