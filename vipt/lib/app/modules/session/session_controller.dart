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

enum TimerStatus {
  play,
  pause,
  rest,
  ready,
}

class SessionController extends GetxController {
  // property

  // collection hiện tại
  WorkoutCollection currentCollection =
      Get.find<WorkoutCollectionController>().selectedCollection!;
  // workout list lấy từ generated list
  List<Workout> workoutList =
      List.from(Get.find<WorkoutCollectionController>().generatedWorkoutList);
  // thời gian của cả collection
  final timeValue = Get.find<WorkoutCollectionController>().timeValue.value;
  // collection setting của collection
  final collectionSetting =
      Get.find<WorkoutCollectionController>().collectionSetting.value;
  // lấy workout hiện tại trong session
  Workout get currentWorkout => workoutList[workoutIndex];
  // controller của collection timer
  final collectionTimeController = MyCountDownController();
  // controller của workout timer
  final workoutTimeController = MyCountDownController();
  // số round của collection
  late int round;
  // tổng calo mà người dùng tiêu thụ dựa trên tương tác của họ
  double caloConsumed = 0.0;
  // tổng thời gian mà người dùng tập dựa trên tương tác của họ
  double timeConsumed = 0.0;

  // list chứa thời gian của các phrase (transition, workout, rest) tính tất cả các round
  List<int> timeList = [];
  // list chứa các activity đại diện cho các phrase tính tất cả các round
  List<Activity> activites = [];

  // index của timeList và activites
  int workoutTimerIndex = 0;
  // index của workoutList
  int workoutIndex = 0;

  // getter lấy các trạng thái hiện tại
  bool get isWorkoutTurn => activites[workoutTimerIndex] == Activity.workout;
  bool get isTransitionTurn =>
      activites[workoutTimerIndex] == Activity.transition;
  bool get isRestTurn => activites[workoutTimerIndex] == Activity.rest;

  TimerStatus status = TimerStatus.ready;

  @override
  void onInit() {
    round = collectionSetting.round;

    initLists();

    super.onInit();
  }

  // method
  // hàm init cho timeList, activites, workoutList
  void initLists() {
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

  void changeTimerState({String action = ''}) {
    if (action == '') {
      if (isRestTurn) {
        status = TimerStatus.rest;
      } else if (isTransitionTurn) {
        status = TimerStatus.ready;
      }
    } else {
      if (action == 'pause') {
        status = TimerStatus.pause;
      } else if (action == 'play') {
        status = TimerStatus.play;
      }
    }
  }

  // hàm khi handle workout timer hoàn thành
  void onWorkoutTimerComplete() {
    calculateCaloConsumed(timeList[workoutTimerIndex]);
    calculateTimeConsumed(timeList[workoutTimerIndex]);

    workoutTimerIndex++;
    changeTimerState();
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

  // hàm handle việc pause
  void pause() {
    collectionTimeController.pause();
    workoutTimeController.pause();
    changeTimerState(action: 'pause');
  }

  // hàm handle việc skip
  void skip() {
    // pause();
    int remainWorkoutTime = int.parse(workoutTimeController.getTime());
    calculateCaloConsumed(remainWorkoutTime);
    calculateCaloConsumed(timeList[workoutTimerIndex] - remainWorkoutTime);

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

  // hàm handle việc start
  void start() {
    collectionTimeController.start();
    workoutTimeController.start();
  }

  // hàm handle việc resume
  void resume() {
    collectionTimeController.resume();
    workoutTimeController.resume();
  }

  // hàm tính toán lại timer khi xong 1 phrase hoặc skip
  void calculateTimer() {
    workoutTimerIndex++;
    changeTimerState();
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

  // hàm chuyển sang workout tiếp theo
  void nextWorkout() {
    workoutIndex++;
  }

  // hàm tính toán lượng calo user tiêu thụ dựa trên tương tác của họ
  void calculateCaloConsumed(int time) {
    if (isTransitionTurn || isRestTurn) {
      time = 0;
    }

    num bodyWeight = DataService.currentUser.currentWeight;
    caloConsumed += SessionUtils.calculateCaloOneWorkout(
        time, currentWorkout.metValue, bodyWeight);
  }

  void calculateTimeConsumed(int time) {
    timeConsumed += time;
  }

  // void start() {
  //   collectionTimeController.start();
  //   workoutTimeController.start();
  //   changeTimerState(action: 'play');
  // }

  // void resume() {
  //   collectionTimeController.resume();
  //   workoutTimeController.resume();
  //   changeTimerState(action: 'play');
  // }
}
