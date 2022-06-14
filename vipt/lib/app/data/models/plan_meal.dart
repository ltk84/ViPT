class PlanMeal {
  int? id;
  final String mealID;
  final int listID;

  PlanMeal({this.id, required this.mealID, required this.listID});

  @override
  String toString() => 'PlanMeal(id: $id, mealID: $mealID, listID: $listID)';

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'mealID': mealID,
      'listID': listID,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory PlanMeal.fromMap(Map<String, dynamic> map) {
    return PlanMeal(
      id: map['id']?.toInt() ?? 0,
      mealID: map['mealID'] ?? '',
      listID: map['listID']?.toInt() ?? 0,
    );
  }
}
