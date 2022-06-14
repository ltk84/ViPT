class PlanMealCollection {
  int? id;
  final DateTime date;
  double mealRatio;
  final int planID;

  PlanMealCollection(
      {this.id,
      required this.date,
      required this.mealRatio,
      required this.planID});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'planID': planID,
      'mealRatio': mealRatio,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory PlanMealCollection.fromMap(Map<String, dynamic> map) {
    return PlanMealCollection(
      id: map['id']?.toInt() ?? 0,
      planID: map['planID']?.toInt() ?? 0,
      date: DateTime.parse(map['date']),
      mealRatio: map['mealRatio'] ?? 0,
    );
  }

  @override
  String toString() =>
      'PlanMealCollection(id: $id, date: $date, mealRatio: $mealRatio)';
}
