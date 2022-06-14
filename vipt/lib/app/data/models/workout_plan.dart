class WorkoutPlan {
  int? id;
  final num dailyGoalCalories;
  final DateTime startDate;
  final DateTime endDate;
  final String userID;

  WorkoutPlan(
      {this.id,
      required this.userID,
      required this.dailyGoalCalories,
      required this.startDate,
      required this.endDate});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'dailyGoalCalories': dailyGoalCalories,
      'userID': userID,
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
      userID: map['userID'] ?? '',
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
