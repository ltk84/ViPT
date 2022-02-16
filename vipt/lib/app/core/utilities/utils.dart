import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout.dart';

class WorkoutCollectionUtils {
  static double calculateCalo(
      {required List<Workout> workoutList,
      required CollectionSetting collectionSetting,
      required num bodyWeight}) {
    double caloValue = 0;
    workoutList
        .map((workout) => {
              caloValue += collectionSetting.round *
                  ((collectionSetting.exerciseTime / 60) *
                      workout.metValue *
                      bodyWeight *
                      3.5) /
                  200
            })
        .toList();
    return caloValue;
  }

  static double calculateTime(
      {required CollectionSetting collectionSetting,
      required int workoutListLenght}) {
    double timeValue = 0;
    int restTimeValue = ((collectionSetting.round * workoutListLenght) %
                collectionSetting.restFrequency ==
            0)
        ? ((collectionSetting.round * workoutListLenght) ~/
                collectionSetting.restFrequency) -
            1
        : (collectionSetting.round *
            workoutListLenght ~/
            collectionSetting.restFrequency);

    timeValue = (collectionSetting.round *
                workoutListLenght *
                (collectionSetting.exerciseTime +
                    collectionSetting.transitionTime) +
            restTimeValue * collectionSetting.restTime) /
        60;
    return timeValue;
  }
}
