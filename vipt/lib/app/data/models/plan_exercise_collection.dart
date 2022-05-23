class PlanExerciseCollection {
  int? id;
  final DateTime date;
  final int collectionSettingID;

  PlanExerciseCollection(
      {this.id, required this.date, required this.collectionSettingID});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'collectionSettingID': collectionSettingID,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory PlanExerciseCollection.fromMap(Map<String, dynamic> map) {
    return PlanExerciseCollection(
      id: map['id']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      collectionSettingID: map['collectionSettingID']?.toInt() ?? 0,
    );
  }

  @override
  String toString() =>
      'WorkoutPlanExercise(id: $id, date: $date, collectionSettingID: $collectionSettingID)';
}
