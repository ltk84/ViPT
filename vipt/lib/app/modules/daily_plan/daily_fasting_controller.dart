import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyFastingController extends GetxController with TrackerController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String timeWhenPause = 'TIME_WHEN_PAUSE';
  static const String timerWhenPause = 'TIMER_WHEN_PAUSE';

  // in second
  Duration timerValueWhenPause = const Duration();
  int appPauseInterval = 0;
  int timerDuration = 60;

  int get initialDuration => timerValueWhenPause.inSeconds + appPauseInterval;

  @override
  void onInit() async {
    super.onInit();
  }

  Future<int> loadTimerInitialValue() async {
    final prefs = await _prefs;
    String? timeWhenPauseInPrefs = prefs.getString(timeWhenPause);
    if (timeWhenPauseInPrefs != null) {
      DateTime time = DateTime.parse(timeWhenPauseInPrefs);
      appPauseInterval = DateTime.now().difference(time).inSeconds;
    }

    String? timerValueInPrefs = prefs.getString(timerWhenPause);
    if (timerValueInPrefs != null) {
      timerValueWhenPause = parseDuration(timerValueInPrefs);
    }

    if (initialDuration > timerDuration) {
      resetData();
    }
    return 1;
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  Future<void> saveDataToPrefs(Duration timerValue) async {
    final prefs = await _prefs;
    prefs.setString(timeWhenPause, DateTime.now().toString());
    prefs.setString(timerWhenPause, timerValue.toString());
  }

  Future<void> resetData() async {
    timerValueWhenPause = const Duration();
    appPauseInterval = 0;
    await removeDataFromPrefs();
  }

  Future<void> removeDataFromPrefs() async {
    final prefs = await _prefs;
    prefs.remove(timeWhenPause);
    prefs.remove(timerWhenPause);
  }

  @override
  fetchTracksByDate(DateTime date) {
    throw UnimplementedError();
  }
}
