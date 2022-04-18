import 'package:get/get.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyWaterController extends GetxController with TrackerController {
  // TODO: doi lai flow: lay tu db theo ngay
  List<WaterTracker> tracks = [
    WaterTracker(date: DateTime.now(), waterVolume: 20),
    WaterTracker(
        date: DateTime.now().add(const Duration(hours: 1)), waterVolume: 50),
    WaterTracker(
        date: DateTime.now().add(const Duration(hours: 2)), waterVolume: 20),
    WaterTracker(
        date: DateTime.now().add(const Duration(hours: 3)), waterVolume: 30),
  ];
  Rx<int> waterVolume = 0.obs;
  late DateTime date;

  @override
  void onInit() {
    super.onInit();
    date = tracks.first.date;
    tracks.map((e) => waterVolume.value += e.waterVolume).toList();
  }

  addWaterVolume(int volume) {
    waterVolume.value += volume;
    tracks.add(WaterTracker(date: DateTime.now(), waterVolume: volume));
    update();
    // TODO: update len db
  }

  deleteWaterVolume(WaterTracker wt) {
    waterVolume.value -= wt.waterVolume;
    tracks.remove(wt);
    update();
    // TODO: update len db
  }
}
