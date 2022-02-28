import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';
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

  final collectionTimeController = MyCountDownController();
  final workoutTimeController = MyCountDownController();
  late int round;

  @override
  void onInit() {
    currentWorkout = workoutList[workoutIndex.value].obs;
    round = collectionSetting.round;

    super.onInit();
  }

  void onWorkoutTimerComplete() {
    if (workoutIndex < workoutList.length) {
      workoutIndex.value++;
      workoutTimeController.restart();
    } else {
      round--;
      if (round > 0) {
        workoutIndex.value = 0;
        workoutTimeController.restart();
      }
    }
  }

  void pause() {
    collectionTimeController.pause();
    workoutTimeController.pause();
  }

  void skip() {
    pause();
    int remainWorkoutTime = int.parse(workoutTimeController.getTime());
    List<String> timeStr = collectionTimeController.getTime().split(':');

    int currentCollectionTime =
        int.parse(timeStr[0]) * 60 + int.parse(timeStr[1]);

    int remainCollectionTime = currentCollectionTime - remainWorkoutTime;

    collectionTimeController.restart(duration: remainCollectionTime);
    workoutTimeController.restart(duration: collectionSetting.exerciseTime);

    workoutIndex.value++;
  }

  void start() {
    collectionTimeController.start();
    workoutTimeController.start();
  }

  void resume() {
    collectionTimeController.resume();
    workoutTimeController.resume();
  }
}
