import 'dart:async';

import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/core/utilities/utils.dart';
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
    DateTime lastDate =
        DateTime.parse(_prefs.getString(lastDateSaved) ?? now.toString());

    if (lastDate.isBefore(now)) {
      lastDate = now;
      savedSteps = event.steps;

      _prefs
        ..setString(lastDateSaved, lastDate.toString())
        ..setInt(savedStepCount, savedSteps);
    }

    steps.value = event.steps - savedSteps;
    print("step: " + steps.value.toString());

    calculateDistanceWithFootStep(steps.value);
  }

  // TODO: tìm hiểu thêm về cách tính khoảng cách dựa trên sô bước
  void calculateDistanceWithFootStep(int footStepCount) {
    final _user = DataService.currentUser;
    distance.value = StepTrackerUtils.calculateDistanceInMeterWithFootStep(
        footStepCount,
        _user.currentHeight.toInt(),
        _user.heightUnit,
        _user.gender);
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
