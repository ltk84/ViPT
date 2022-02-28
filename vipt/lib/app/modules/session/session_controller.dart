import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/modules/session/widgets/custom_timer.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class SessionController extends GetxController {
  WorkoutCollection currentCollection =
      Get.find<WorkoutCollectionController>().selectedCollection!;
  List<Workout> workoutList =
      Get.find<WorkoutCollectionController>().generatedWorkoutList;
  Rx<int> workoutTimerIndex = 0.obs;
  late Rx<Workout> currentWorkout;

  final timeValue = Get.find<WorkoutCollectionController>().timeValue.value;

  final collectionSetting =
      Get.find<WorkoutCollectionController>().collectionSetting.value;

  final collectionTimeController = MyCountDownController();
  final workoutTimeController = MyCountDownController();
  late int round;

  late VideoPlayerController videoPlayerController;

  List<int> timeList = [];

  @override
  void onInit() {
    currentWorkout = workoutList[workoutTimerIndex.value].obs;
    round = collectionSetting.round;

    initTimeList();
    initVideoPlayer();

    super.onInit();
  }

  void initVideoPlayer() {
    var link =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    videoPlayerController = VideoPlayerController.network(link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        update();
        videoPlayerController.play();
      });
  }

  void initTimeList() {
    int transitionTime = collectionSetting.transitionTime;
    int workoutTime = collectionSetting.exerciseTime;
    int restTime = collectionSetting.restTime;
    int restFreq = collectionSetting.restFrequency;
    for (int i = 0; i < workoutList.length; i++) {
      timeList.add(transitionTime);
      timeList.add(workoutTime);
      if ((i + 1) % restFreq == 0 && i + 1 != workoutList.length) {
        timeList.add(restTime);
      }
    }

    int round = collectionSetting.round;
    List<int> cloneList = timeList.sublist(0);

    for (int i = 1; i < round; i++) {
      timeList.add(restTime);
      timeList.addAll(cloneList);
    }
  }

  void onWorkoutTimerComplete() {
    workoutTimerIndex.value++;
    if (workoutTimerIndex.value < timeList.length) {
      workoutTimeController.restart(
          duration: timeList[workoutTimerIndex.value]);
    } else {
      workoutTimeController.pause();
      workoutTimerIndex.value = 0;
    }
  }

  void pause() {
    collectionTimeController.pause();
    workoutTimeController.pause();
  }

  void skip() {
    pause();
    workoutTimerIndex.value++;
    int remainWorkoutTime = int.parse(workoutTimeController.getTime());
    List<String> timeStr = collectionTimeController.getTime().split(':');

    int currentCollectionTime =
        int.parse(timeStr[0]) * 60 + int.parse(timeStr[1]);

    int remainCollectionTime = currentCollectionTime - remainWorkoutTime;

    collectionTimeController.restart(duration: remainCollectionTime);
    workoutTimeController.restart(duration: timeList[workoutTimerIndex.value]);
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
