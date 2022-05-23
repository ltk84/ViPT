class WorkoutPlan {
  final int? id;
  final num dailyGoalCalories;
  final DateTime startDate;
  final DateTime endDate;

  WorkoutPlan(
      {this.id,
      required this.dailyGoalCalories,
      required this.startDate,
      required this.endDate});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'dailyGoalCalories': dailyGoalCalories,
      'startDate': startDate.toString(),
      'endDate': endDate.toString(),
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory WorkoutPlan.fromMap(Map<String, dynamic> map) {
    return WorkoutPlan(
      id: map['id']?.toInt(),
      dailyGoalCalories: map['dailyGoalCalories'] ?? 0,
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }

  @override
  String toString() {
    return 'WorkoutPlan(id: $id, dailyGoalCalories: $dailyGoalCalories, startDate: $startDate, endDate: $endDate)';
  }
}
