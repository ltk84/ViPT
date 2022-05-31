import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/water_tracker.dart';
import 'package:vipt/app/data/others/tab_refesh_controller.dart';
import 'package:vipt/app/data/providers/water_track_provider.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyWaterController extends GetxController with TrackerController {
  final _provider = WaterTrackProvider();
  Rx<int> waterVolume = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchTracksByDate(DateTime.now());
  }

  @override
  fetchTracksByDate(DateTime date) async {
    this.date = date;
    tracks = await _provider.fetchByDate(date);
    waterVolume.value = 0;
    tracks.map((e) {
      e = e as WaterTracker;
      waterVolume.value += e.waterVolume;
    }).toList();
    update();
  }

  addTrack(int volume) async {
    waterVolume.value += volume;
    WaterTracker wt = WaterTracker(
        date: DateUtils.isSameDay(date, DateTime.now()) ? DateTime.now() : date,
        waterVolume: volume);
    wt = await _provider.add(wt);
    tracks.add(wt);
    update();

    _markRelevantTabToUpdate();
  }

  void _markRelevantTabToUpdate() {
    if (!RefeshTabController.instance.isProfileTabNeedToUpdate) {
      RefeshTabController.instance.toggleProfileTabUpdate();
    }
  }

  deleteTrack(WaterTracker wt) async {
    waterVolume.value -= wt.waterVolume;
    tracks.remove(wt);
    await _provider.delete(wt.id ?? 0);
    update();

    _markRelevantTabToUpdate();
  }
}
