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
      required int workoutListLength}) {
    double timeValue = 0;
    int restTimeValue = ((collectionSetting.round * workoutListLength) %
                collectionSetting.restFrequency ==
            0)
        ? ((collectionSetting.round * workoutListLength) ~/
                collectionSetting.restFrequency) -
            1
        : (collectionSetting.round *
            workoutListLength ~/
            collectionSetting.restFrequency);

    timeValue = (collectionSetting.round *
                workoutListLength *
                (collectionSetting.exerciseTime +
                    collectionSetting.transitionTime) +
            restTimeValue * collectionSetting.restTime) /
        60;
    return timeValue;
  }
}
