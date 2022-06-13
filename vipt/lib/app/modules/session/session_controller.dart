import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/daily_plan/daily_exercise_controller.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

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
  // biến phân biệt user collection vs default collection
  final isDefaultCollection =
      Get.find<WorkoutCollectionController>().isDefaultCollection;
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
  // số bài tập hoàn thành
  int completedWorkout = 0;

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

  // getter lấy các trạng thái hiện tại (khác trên)
  bool get isPlaying => status.value == TimerStatus.play;
  bool get isPause => status.value == TimerStatus.pause;
  bool get isRest => status.value == TimerStatus.rest;
  bool get isReady => status.value == TimerStatus.ready;

  Rx<TimerStatus> status = TimerStatus.ready.obs;

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
    if (action == 'pause') {
      status.value = TimerStatus.pause;
      return;
    }

    if (isRestTurn) {
      status.value = TimerStatus.rest;
    } else if (isTransitionTurn) {
      status.value = TimerStatus.ready;
    } else if (isWorkoutTurn) {
      status.value = TimerStatus.play;
    }
  }

  // hàm khi handle workout timer hoàn thành
  void onWorkoutTimerComplete() {
    calculateTimeConsumed(timeList[workoutTimerIndex]);

    if (isWorkoutTurn) {
      calculateCaloConsumed(timeList[workoutTimerIndex]);
      completedWorkout++;
    }

    workoutTimerIndex++;
    if (workoutTimerIndex >= timeList.length) {
      workoutTimerIndex--;
      return;
    }

    changeTimerState();
    if (isTransitionTurn) {
      nextWorkout();
    }
    workoutTimeController.restart(duration: timeList[workoutTimerIndex]);
  }

  // hàm handle việc pause
  void pause() {
    collectionTimeController.pause();
    workoutTimeController.pause();
    changeTimerState(action: 'pause');
  }

  // hàm handle việc skip
  Future<void> skip() async {
    int remainWorkoutTime = int.parse(workoutTimeController.getTime());
    // chỗ này sao lại gọi luôn remainWorkoutTime nhỉ???
    // calculateCaloConsumed(remainWorkoutTime);
    calculateCaloConsumed(timeList[workoutTimerIndex] - remainWorkoutTime);

    if (isWorkoutTurn || isRestTurn) {
      calculateTimer();
    } else {
      calculateTimer();
      calculateTimer();
    }

    if (workoutTimerIndex >= timeList.length) {
      workoutTimerIndex--;
      await handleCompleteSession();
      //Get.back();
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
    changeTimerState(action: 'play');
  }

  // hàm handle việc resume
  void resume() {
    collectionTimeController.resume();
    workoutTimeController.resume();
    changeTimerState(action: 'play');
  }

  // hàm tính toán lại timer khi xong 1 phrase hoặc skip
  void calculateTimer() {
    workoutTimerIndex++;
    if (workoutTimerIndex >= timeList.length) {
      return;
    }
    changeTimerState();

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
    if (workoutIndex + 1 < workoutList.length) {
      workoutIndex++;
    }
  }

  // hàm tính toán lượng calo user tiêu thụ dựa trên tương tác của họ
  void calculateCaloConsumed(int time) {
    if (isTransitionTurn || isRestTurn) {
      time = 0;
    }

    num bodyWeight = DataService.currentUser!.currentWeight;
    caloConsumed += SessionUtils.calculateCaloOneWorkout(
        time, currentWorkout.metValue, bodyWeight);
  }

  void calculateTimeConsumed(int time) {
    timeConsumed += time;
  }

  Future<void> handleCompleteSession() async {
    // đảm bảo collection timer kết thúc sau workout timer.
    await Future.delayed(const Duration(seconds: 1));

    collectionTimeController.pause();

    ExerciseTracker et = ExerciseTracker(
        date: DateTime.now(),
        outtakeCalories: caloConsumed.ceil(),
        sessionNumber: 1,
        totalTime: timeConsumed.ceil());

    await ExerciseTrackProvider().add(et);
    final _c = Get.put(DailyExerciseController());
    await _c.fetchTracksByDate(_c.date);
    await Get.delete<DailyExerciseController>();

    _markRelevantTabToUpdate();

    await Get.toNamed(Routes.completeSession);
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isPlanTabNeedToUpdate) {
      RefeshTabController.instance.togglePlanTabUpdate();
    }

    if (!RefeshTabController.instance.isDailyTabNeedToUpdate) {
      RefeshTabController.instance.toggleDailyTabUpdate();
    }

    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }
  }
}
