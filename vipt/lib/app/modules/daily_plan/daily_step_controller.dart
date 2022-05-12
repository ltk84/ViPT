import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';
import 'package:vipt/app/modules/daily_plan/tracker_controller.dart';

class DailyStepController extends GetxController with TrackerController {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  RxString status = '?'.obs, steps = '?'.obs;

  @override
  fetchTracksByDate(DateTime date) {
    throw UnimplementedError();
  }

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    steps.value = event.steps.toString();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    status.value = event.status;
  }

  void onPedestrianStatusError(error) {
    status.value = 'Pedestrian Status not available';
  }

  void onStepCountError(error) {
    steps.value = 'Step Count not available';
  }
}
