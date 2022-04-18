import 'package:get/get.dart';
import 'package:vipt/app/data/models/exercise_tracker.dart';
import 'package:vipt/app/data/providers/exercise_track_provider.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyExerciseController extends GetxController with TrackerController {
  final _provider = ExerciseTrackProvider();
  late List<ExerciseTracker> tracks;
  Rx<int> calories = 0.obs;
  Rx<int> sessions = 0.obs;
  Rx<int> time = 0.obs;
  late DateTime date;

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
      calories.value += e.outtakeCalories;
      time.value += e.totalTime;
      sessions.value += e.sessionNumber;
    }).toList();
    update();
  }
}
