import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/providers/water_track_provider.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyWaterController extends GetxController with TrackerController {
  final _provider = WaterTrackProvider();

  // late List<WaterTracker> tracks = [
  //   WaterTracker(date: DateTime.now(), waterVolume: 20),
  //   WaterTracker(
  //       date: DateTime.now().add(const Duration(hours: 1)), waterVolume: 50),
  //   WaterTracker(
  //       date: DateTime.now().add(const Duration(hours: 2)), waterVolume: 20),
  //   WaterTracker(
  //       date: DateTime.now().add(const Duration(hours: 3)), waterVolume: 30),
  // ];
  late List<WaterTracker> tracks;
  Rx<int> waterVolume = 0.obs;
  late DateTime date;

  @override
  void onInit() async {
    super.onInit();
    await updateTracksByDate(DateTime.now());
  }

  updateTracksByDate(DateTime date) async {
    this.date = date;
    tracks = await _provider.fetchByDate(date);
    waterVolume.value = 0;
    tracks.map((e) => waterVolume.value += e.waterVolume).toList();
    update();
  }

  addWaterVolume(int volume) async {
    waterVolume.value += volume;
    WaterTracker wt = WaterTracker(
        date: DateUtils.isSameDay(date, DateTime.now()) ? DateTime.now() : date,
        waterVolume: volume);
    tracks.add(wt);
    await _provider.add(wt);
    update();
  }

  deleteWaterVolume(WaterTracker wt) async {
    waterVolume.value -= wt.waterVolume;
    tracks.remove(wt);
    await _provider.delete(wt.id ?? 0);
    update();
  }
}
