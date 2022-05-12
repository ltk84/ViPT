import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

enum TimerState { ready, running }

class DailyFastingController extends GetxController with TrackerController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String timeWhenPause = 'TIME_WHEN_PAUSE';
  static const String timerWhenPause = 'TIMER_WHEN_PAUSE';
  static const String timerStartTime = 'TIMER_START_AT';
  static const String readyTimerValue = '__:__';

  static DateTime defaultDateTime = DateTime.now();
  static List<Map<String, int>> typeOfFasting = [
    {'fastTime': 12, 'eatTime': 12},
    {'fastTime': 13, 'eatTime': 11},
    {'fastTime': 14, 'eatTime': 10},
    {'fastTime': 15, 'eatTime': 9},
    {'fastTime': 16, 'eatTime': 8},
    {'fastTime': 17, 'eatTime': 7},
    {'fastTime': 18, 'eatTime': 6},
    {'fastTime': 19, 'eatTime': 5},
    {'fastTime': 20, 'eatTime': 4},
    {'fastTime': 21, 'eatTime': 3},
    {'fastTime': 22, 'eatTime': 2},
    {'fastTime': 23, 'eatTime': 1},
  ];

  Rx<TimerState> timerState = TimerState.ready.obs;

  // in second
  Duration timerValueWhenPause = const Duration();
  int appPauseInterval = 0;
  // chuyển từ giờ -> giây
  // test
  int timerDuration = (typeOfFasting[0]['fastTime'] ?? 1) * 60 * 60;
  // int timerDuration = const Duration(minutes: 2).inSeconds;

  Rx<int> fastTypeIndex = 0.obs;
  late DateTime startTime = defaultDateTime;
  late DateTime endTimeFasting = defaultDateTime.add(const Duration(hours: 1));
  late DateTime endTimeEating = defaultDateTime.add(const Duration(hours: 2));

  int get initialDuration => timerValueWhenPause.inSeconds + appPauseInterval;

  Rx<String> fastingStartTimeStr = readyTimerValue.obs;
  Rx<String> fastingEndTimeStr = readyTimerValue.obs;
  Rx<String> eatingStartTimeStr = readyTimerValue.obs;
  Rx<String> eatingEndTimeStr = readyTimerValue.obs;

  Map<String, int> getTypeOfFasting(int index) => typeOfFasting[index];

  @override
  void onInit() async {
    super.onInit();
    await loadTimeLine();

    ever(fastTypeIndex, (_) async {
      await loadTimeLine();
    });
  }

  bool timerIsRunning() => timerState.value == TimerState.running;

  void setTimeLineStrings() {
    fastingStartTimeStr.value = '${startTime.hour}:${startTime.minute}';
    fastingEndTimeStr.value = '${endTimeFasting.hour}:${endTimeFasting.minute}';
    eatingStartTimeStr.value =
        '${endTimeFasting.hour}:${endTimeFasting.minute}';
    eatingEndTimeStr.value = '${endTimeEating.hour}:${endTimeEating.minute}';
  }

  void resetTimeLineStrings() {
    fastingStartTimeStr.value = readyTimerValue;
    fastingEndTimeStr.value = readyTimerValue;
    eatingStartTimeStr.value = readyTimerValue;
    eatingEndTimeStr.value = readyTimerValue;
  }

  Future<void> loadTimeLine() async {
    final prefs = await _prefs;
    // add timerStartTIme
    String? timerSt = prefs.getString(timerStartTime);
    if (timerSt != null) {
      startTime = DateTime.parse(timerSt);
    } else {
      startTime = defaultDateTime;
    }

    endTimeFasting = startTime.add(
        Duration(hours: typeOfFasting[fastTypeIndex.value]['fastTime'] ?? 0));
    endTimeEating = endTimeFasting.add(
        Duration(hours: typeOfFasting[fastTypeIndex.value]['eatTime'] ?? 0));
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
