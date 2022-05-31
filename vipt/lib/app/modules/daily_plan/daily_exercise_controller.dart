import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyExerciseController extends GetxController with TrackerController {
  final _provider = ExerciseTrackProvider();
  Rx<int> calories = 0.obs;
  Rx<int> sessions = 0.obs;
  Rx<double> time = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchTracksByDate(DateTime.now());
  }

  @override
  fetchTracksByDate(DateTime date) async {
    this.date = date;
    tracks = await _provider.fetchByDate(date);
    calories.value = 0;
    sessions.value = 0;
    time.value = 0;
    tracks.map((e) {
      e = e as ExerciseTracker;
      calories.value += e.outtakeCalories;
      time.value += e.totalTime;
      sessions.value += e.sessionNumber;
    }).toList();
    update();
  }

  Future<void> addTrack(int newCalories) async {
    calories.value += newCalories;
    ExerciseTracker et = ExerciseTracker(
        date: date,
        outtakeCalories: newCalories,
        sessionNumber: 0,
        totalTime: 0);
    et = await _provider.add(et);
    update();

    _markRelevantTabToUpdate();
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }

    if (!RefeshTabController.instance.isPlanTabNeedToUpdate) {
      RefeshTabController.instance.togglePlanTabUpdate();
    }
  }
}
