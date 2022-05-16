import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/data/models/step_tracker.dart';
import 'package:vipt/app/data/providers/step_tracker_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyStepController extends GetxController with TrackerController {
  static const int defaultStepValue = 0;
  static const double defaultDistanceValue = 0;
  static const String savedStepCount = 'savedStepCount';
  static const String lastDateSaved = 'lastDateSaved';

  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  RxInt steps = defaultStepValue.obs;
  RxDouble distance = defaultDistanceValue.obs;

  final _stepTrackProvider = StepTrackerProvider();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;

    _stepCountStream.listen(onStepCountDaily,
        cancelOnError: true, onError: onStepCountError);

    _pedestrianStatusStream.listen(onPedestrianStatusChanged,
        onError: onPedestrianStatusError);
  }

  void onStepCountDaily(StepCount event) async {
    final _prefs = await prefs;
    int savedSteps = _prefs.getInt(savedStepCount) ?? 0;
    if (event.steps < savedSteps) {
      savedSteps = 0;
      _prefs.setInt(savedStepCount, savedSteps);
    }

    DateTime now = DateTime.now();
    String? lastDateStr = _prefs.getString(lastDateSaved);
    if (lastDateStr != null) {
      DateTime lastDate = DateTime.parse(lastDateStr);

      if (DateUtils.dateOnly(lastDate).isBefore(DateUtils.dateOnly(now))) {
        lastDate = now;
        savedSteps = event.steps;

        _prefs
          ..setString(lastDateSaved, lastDate.toString())
          ..setInt(savedStepCount, savedSteps);
      }
    } else {
      savedSteps = event.steps;

      _prefs
        ..setString(lastDateSaved, now.toString())
        ..setInt(savedStepCount, savedSteps);
    }

    steps.value = event.steps - savedSteps;
    print('count step daily');
    print("step: " + steps.value.toString());

    _calculateDistanceWithFootStep(steps.value);
  }

  // TODO: tìm hiểu thêm về cách tính khoảng cách dựa trên sô bước
  void _calculateDistanceWithFootStep(int footStepCount) {
    final _user = DataService.currentUser;
    if (_user == null) return;
    distance.value = StepTrackerUtils.calculateDistanceInMeterWithFootStep(
        footStepCount,
        _user.currentHeight.toInt(),
        _user.heightUnit,
        _user.gender);
  }

  Future<void> updateDailyStepTrackToDB() async {
    print('update to db: ' + steps.value.toString());
    final _prefs = await prefs;
    String? lastDateStr = _prefs.getString(lastDateSaved);

    if (lastDateStr != null) {
      DateTime lastDate = DateTime.parse(lastDateStr);
      List<StepTracker> result = await _stepTrackProvider.fetchByDate(lastDate);
      if (result.isEmpty) {
        StepTracker track = StepTracker(date: lastDate, stepCount: steps.value);
        await _stepTrackProvider.add(track);
      } else {
        StepTracker exsitTrack = result[0];
        await _stepTrackProvider.update(exsitTrack.id ?? 0,
            StepTracker(date: lastDate, stepCount: steps.value));
      }
    }
  }

  void onStepCountError(error) {
    print(error);
    steps.value = defaultStepValue;
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {}

  void onPedestrianStatusError(error) {}

  @override
  fetchTracksByDate(DateTime date) {
    throw UnimplementedError();
  }
}
