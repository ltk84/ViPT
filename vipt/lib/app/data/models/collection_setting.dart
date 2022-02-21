import 'dart:convert';

class CollectionSetting {
  int round;
  int numOfWorkoutPerRound;
  bool isStartWithWarmUp;
  bool isShuffle;
  int exerciseTime;
  int transitionTime;
  int restTime;
  int restFrequency;

  CollectionSetting({
    this.round = 3,
    this.numOfWorkoutPerRound = 5,
    this.isStartWithWarmUp = true,
    this.isShuffle = true,
    this.exerciseTime = 10,
    this.transitionTime = 10,
    this.restTime = 10,
    this.restFrequency = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'round': round,
      'numOfWorkoutPerRound': numOfWorkoutPerRound,
      'isStartWithWarmUp': isStartWithWarmUp,
      'isShuffle': isShuffle,
      'exerciseTime': exerciseTime,
      'transitionTime': transitionTime,
      'restTime': restTime,
      'restFrequency': restFrequency,
    };
  }

  String toJson() => json.encode(toMap());

  factory CollectionSetting.fromJson(String source) =>
      CollectionSetting.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CollectionSetting(round: $round, numOfWorkoutPerRound: $numOfWorkoutPerRound, isStartWithWarmUp: $isStartWithWarmUp, isShuffle: $isShuffle, exerciseTime: $exerciseTime, transitionTime: $transitionTime, restTime: $restTime, restFrequency: $restFrequency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollectionSetting &&
        other.round == round &&
        other.isStartWithWarmUp == isStartWithWarmUp &&
        other.isShuffle == isShuffle &&
        other.exerciseTime == exerciseTime &&
        other.transitionTime == transitionTime &&
        other.restTime == restTime &&
        other.restFrequency == restFrequency;
  }

  @override
  int get hashCode {
    return round.hashCode ^
        isStartWithWarmUp.hashCode ^
        isShuffle.hashCode ^
        exerciseTime.hashCode ^
        transitionTime.hashCode ^
        restTime.hashCode ^
        restFrequency.hashCode;
  }

  factory CollectionSetting.fromMap(Map<String, dynamic> map) {
    return CollectionSetting(
      round: map['round'].toInt() ?? 0,
      numOfWorkoutPerRound: map['numOfWorkoutPerRound'] ?? 0,
      isStartWithWarmUp: map['isStartWithWarmUp'] ?? false,
      isShuffle: map['isShuffle'] ?? false,
      exerciseTime: map['exerciseTime'].toInt() ?? 0,
      transitionTime: map['transitionTime'].toInt() ?? 0,
      restTime: map['restTime'].toInt() ?? 0,
      restFrequency: map['restFrequency'].toInt() ?? 0,
    );
  }
}
