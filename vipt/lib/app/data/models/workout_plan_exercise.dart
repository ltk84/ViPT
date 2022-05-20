class WorkoutPlanExercise {
  final int? id;
  final DateTime date;
  final String exerciseID;

  WorkoutPlanExercise({this.id, required this.date, required this.exerciseID});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'mealID': exerciseID,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory WorkoutPlanExercise.fromMap(Map<String, dynamic> map) {
    return WorkoutPlanExercise(
      id: map['id']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      exerciseID: map['exerciseID'] ?? '',
    );
  }

  @override
  String toString() =>
      'WorkoutPlanExercise(id: $id, date: $date, mealID: $exerciseID)';
}
