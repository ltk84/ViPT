import 'package:get/get.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/enums/app_enums.dart';

class WorkoutPlanController extends GetxController {
  static const num defaultWeightValue = 0;
  static const WeightUnit defaultWeightUnit = WeightUnit.kg;
  Rx<num> currentWeight = defaultWeightValue.obs;
  Rx<num> goalWeight = defaultWeightValue.obs;
  WeightUnit weightUnit = defaultWeightUnit;

  String get unit => weightUnit == WeightUnit.kg ? 'kg' : 'lbs';

  @override
  void onInit() {
    super.onInit();
    loadWeightValues();
  }

  Future<void> loadWeightValues() async {
    final _userInfo = DataService.currentUser;
    if (_userInfo == null) {
      return;
    }

    currentWeight.value = _userInfo.currentWeight;
    goalWeight.value = _userInfo.goalWeight;
    weightUnit = _userInfo.weightUnit;
  }
}
