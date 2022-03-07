import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

enum Activity {
  workout,
  rest,
  transition,
}

class SessionController extends GetxController {
  WorkoutCollection currentCollection =
      Get.find<WorkoutCollectionController>().selectedCollection!;
  List<Workout> workoutList =
      List.from(Get.find<WorkoutCollectionController>().generatedWorkoutList);

  int workoutTimerIndex = 0;
  int workoutIndex = 0;
  Workout get currentWorkout => workoutList[workoutIndex];

  final timeValue = Get.find<WorkoutCollectionController>().timeValue.value;

  final collectionSetting =
      Get.find<WorkoutCollectionController>().collectionSetting.value;

  final collectionTimeController = MyCountDownController();
  final workoutTimeController = MyCountDownController();

  late int round;
  double caloConsumed = 0.0;

  List<int> timeList = [];
  List<Activity> activites = [];

  bool get isWorkoutTurn => activites[workoutTimerIndex] == Activity.workout;
  bool get isTransitionTurn =>
      activites[workoutTimerIndex] == Activity.transition;
  bool get isRestTurn => activites[workoutTimerIndex] == Activity.rest;

  @override
  void onInit() {
    round = collectionSetting.round;

    initTimeListAndActivities();

    super.onInit();
  }

  void initTimeListAndActivities() {
    int transitionTime = collectionSetting.transitionTime;
    int workoutTime = collectionSetting.exerciseTime;
    int restTime = collectionSetting.restTime;
    int restFreq = collectionSetting.restFrequency;

    for (int i = 0; i < workoutList.length; i++) {
      timeList.add(transitionTime);
      activites.add(Activity.transition);

      timeList.add(workoutTime);
      activites.add(Activity.workout);

      if ((i + 1) % restFreq == 0 && i + 1 != workoutList.length) {
        timeList.add(restTime);
        activites.add(Activity.rest);
      }
    }

    int round = collectionSetting.round;
    List<int> cloneList = timeList.sublist(0);
    List<Activity> activityClone = activites.sublist(0);
    List<Workout> workoutClone = workoutList.sublist(0);

    for (int i = 1; i < round; i++) {
      timeList.add(restTime);
      activites.add(Activity.rest);

      timeList.addAll(cloneList);
      activites.addAll(activityClone);
      workoutList.addAll(workoutClone);
    }
  }

  void onWorkoutTimerComplete() {
    calculateCaloConsumed(timeList[workoutTimerIndex]);

    workoutTimerIndex++;
    if (workoutTimerIndex < timeList.length) {
      if (isTransitionTurn) {
        nextWorkout();
      }
      workoutTimeController.restart(duration: timeList[workoutTimerIndex]);
    } else {
      workoutTimeController.pause();
      workoutTimerIndex = 0;
    }
  }

  void pause() {
    collectionTimeController.pause();
    workoutTimeController.pause();
  }

  void skip() {
    // pause();
    int remainWorkoutTime = int.parse(workoutTimeController.getTime());
    calculateCaloConsumed(remainWorkoutTime);

    print(caloConsumed);

    if (isWorkoutTurn || isRestTurn) {
      calculateTimer();
    } else {
      calculateTimer();
      calculateTimer();
    }

    if (workoutTimerIndex >= timeList.length) {
      Get.back();
      return;
    }

    if (isTransitionTurn) {
      nextWorkout();
    }
  }

  void calculateTimer() {
    workoutTimerIndex++;

    if (workoutTimerIndex >= timeList.length) {
      return;
    }

    int remainWorkoutTime = int.parse(workoutTimeController.getTime());
    List<String> timeStr = collectionTimeController.getTime().split(':');

    int currentCollectionTime =
        int.parse(timeStr[0]) * 60 + int.parse(timeStr[1]);

    int remainCollectionTime = currentCollectionTime - remainWorkoutTime;

    collectionTimeController.restart(duration: remainCollectionTime);
    workoutTimeController.restart(duration: timeList[workoutTimerIndex]);
  }

  void nextWorkout() {
    workoutIndex++;
  }

  void calculateCaloConsumed(int time) {
    if (isTransitionTurn || isRestTurn) {
      time = 0;
    }

    num bodyWeight = DataService.currentUser.currentWeight;
    caloConsumed += SessionUtils.calculateCaloOneWorkout(
        time, currentWorkout.metValue, bodyWeight);
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
