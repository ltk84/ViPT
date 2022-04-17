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
  int waterVolume = 0;
  late DateTime date;

  @override
  void onInit() {
    super.onInit();
    date = tracks.first.date;
    tracks.map((e) => waterVolume += e.waterVolume).toList();
  }

  addWaterVolume(int volume) {}
}
