class PlanExercise {
  int? id;
  final String exerciseID;
  final int listID;

  PlanExercise({this.id, required this.exerciseID, required this.listID});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'exerciseID': exerciseID,
      'listID': listID,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory PlanExercise.fromMap(Map<String, dynamic> map) {
    return PlanExercise(
      id: map['id']?.toInt() ?? 0,
      exerciseID: map['exerciseID'] ?? '',
      listID: map['listID']?.toInt() ?? 0,
    );
  }

  @override
  String toString() =>
      'PlanExercise(id: $id, exerciseID: $exerciseID, listID: $listID)';
}
