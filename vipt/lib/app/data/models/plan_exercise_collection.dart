class PlanExerciseCollection {
  int? id;
  final DateTime date;
  final int collectionSettingID;
  final int planID;

  PlanExerciseCollection(
      {this.id,
      required this.date,
      required this.planID,
      required this.collectionSettingID});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'collectionSettingID': collectionSettingID,
      'planID': planID,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory PlanExerciseCollection.fromMap(Map<String, dynamic> map) {
    return PlanExerciseCollection(
      id: map['id']?.toInt() ?? 0,
      planID: map['planID']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      collectionSettingID: map['collectionSettingID']?.toInt() ?? 0,
    );
  }

  @override
  String toString() =>
      'PlanExerciseCollection(id: $id, date: $date, collectionSettingID: $collectionSettingID)';
}
