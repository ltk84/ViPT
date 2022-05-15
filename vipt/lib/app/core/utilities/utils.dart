import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/enums/app_enums.dart';

class WorkoutCollectionUtils {
  static double calculateCalo(
      {required List<Workout> workoutList,
      required CollectionSetting collectionSetting,
      required num bodyWeight}) {
    double caloValue = 0;
    workoutList.map((workout) {
      caloValue += collectionSetting.round *
          ((collectionSetting.exerciseTime / 60) *
              workout.metValue *
              bodyWeight *
              3.5) /
          200;
    }).toList();
    return caloValue;
  }

  static double calculateTime(
      {required CollectionSetting collectionSetting,
      required int workoutListLength}) {
    double timeValue = 0;
    int restTimeValue =
        ((workoutListLength % collectionSetting.restFrequency == 0)
                    ? (workoutListLength ~/ collectionSetting.restFrequency) - 1
                    : workoutListLength ~/ collectionSetting.restFrequency) *
                collectionSetting.round +
            collectionSetting.round -
            1;

    timeValue = (collectionSetting.round *
                workoutListLength *
                (collectionSetting.exerciseTime +
                    collectionSetting.transitionTime) +
            restTimeValue * collectionSetting.restTime) /
        60;
    return timeValue < 0 ? 0 : timeValue;
  }
}

class SessionUtils {
  static double calculateCaloOneWorkout(
      int time, num metValue, num bodyWeight) {
    double caloValue = ((time / 60) * metValue * bodyWeight * 3.5) / 200;
    return caloValue;
  }
}

class StepTrackerUtils {
  static double calculateDistanceInMeterWithFootStep(
      int footStepCount, int userHeight, HeightUnit heightUnit, Gender gender) {
    const double centiToMeterMetric = 0.01;
    const double feetToMeterMetric = 0.3048;
    const double calDistanceMetricForMale = 0.46;
    const double calDistanceMetricForFemale = 0.45;

    double userHeightInMeter = heightUnit == HeightUnit.cm
        ? userHeight * centiToMeterMetric
        : userHeight * feetToMeterMetric;

    double selectedMetric = gender == Gender.male
        ? calDistanceMetricForMale
        : calDistanceMetricForFemale;
    return userHeightInMeter * selectedMetric * footStepCount;
  }
}
