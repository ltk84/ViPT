import 'package:vipt/app/data/models/collection_setting.dart';

class PlanExerciseCollectionSetting extends CollectionSetting {
  int? id;

  PlanExerciseCollectionSetting({
    this.id,
    required int round,
    required int numOfWorkoutPerRound,
    required int exerciseTime,
  }) : super(
          round: round,
          numOfWorkoutPerRound: numOfWorkoutPerRound,
          exerciseTime: exerciseTime,
        );

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'round': round,
      'numOfWorkoutPerRound': numOfWorkoutPerRound,
      'isStartWithWarmUp': isStartWithWarmUp,
      'isShuffle': isShuffle,
      'exerciseTime': exerciseTime,
      'transitionTime': transitionTime,
      'restTime': restTime,
      'restFrequency': restFrequency,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory PlanExerciseCollectionSetting.fromMap(Map<String, dynamic> map) {
    return PlanExerciseCollectionSetting(
      id: map['id']?.toInt() ?? 0,
      round: map['round'].toInt() ?? 0,
      numOfWorkoutPerRound: map['numOfWorkoutPerRound'] ?? 0,
      exerciseTime: map['exerciseTime'].toInt() ?? 0,
    );
  }
}
