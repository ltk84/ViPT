import 'package:vipt/app/data/models/tracker.dart';

class WeightTracker extends Tracker {
  final int weight;
  WeightTracker({int? id, required DateTime date, required this.weight})
      : super(id: id, date: date);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'weight': weight,
    };

    if (super.id != null) {
      map['id'] = super.id;
    }

    return map;
  }

  factory WeightTracker.fromMap(Map<String, dynamic> map) {
    return WeightTracker(
        id: map['id'] ?? 0,
        date: DateTime.parse(map['date']),
        weight: map['weight'] ?? 0);
  }

  @override
  String toString() => 'WeightTracker(id: $id, date: $date, weight: $weight)';
}
