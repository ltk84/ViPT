import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
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

class WorkoutPlanUtils {
  static num _calculateBMR(ViPTUser user) {
    WeightUnit weightUnit = user.weightUnit;
    HeightUnit heightUnit = user.heightUnit;

    num weight = weightUnit == WeightUnit.kg
        ? user.currentWeight
        : user.currentWeight * 0.45359237;
    num height = heightUnit == HeightUnit.cm
        ? user.currentHeight
        : user.currentHeight * 0.032808399;

    Gender gender = user.gender;
    int constantValue = gender == Gender.male ? 5 : -161;
    int age = DateTime.now().year - user.dateOfBirth.year;
    if (age <= 0) {
      throw Exception(
          "Invalide Date of Birth (${user.dateOfBirth}) is after now (${DateTime.now()}))");
    }

    return 10 * weight + 6.25 * height - 5 * age + constantValue;
  }

  static num _calculateTDEE(num bmr, ActiveFrequency activeFrequency) {
    num fValue = 0;
    switch (activeFrequency) {
      case ActiveFrequency.notMuch:
        fValue = 1.2;
        break;
      case ActiveFrequency.few:
        fValue = 1.375;
        break;
      case ActiveFrequency.average:
        fValue = 1.55;
        break;
      case ActiveFrequency.much:
        fValue = 1.725;
        break;
      case ActiveFrequency.soMuch:
        fValue = 1.9;
        break;
    }

    return fValue * bmr;
  }

  static num createDailyGoalCalories(ViPTUser user) {
    num dailyGoalCalories = 0;
    num bmr = _calculateBMR(user);
    num tdee = _calculateTDEE(bmr, user.activeFrequency);
    int intensity = AppValue.intensityWeight;

    if (user.currentWeight < user.goalWeight) {
      dailyGoalCalories = tdee + intensity;
    } else if (user.currentWeight > user.goalWeight) {
      dailyGoalCalories = tdee - intensity;
    } else {
      dailyGoalCalories = tdee;
    }
    return dailyGoalCalories;
  }
}
