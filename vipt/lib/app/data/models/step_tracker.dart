import 'package:vipt/app/data/models/tracker.dart';

class StepTracker extends Tracker {
  final int stepCount;
  StepTracker({
    int? id,
    required DateTime date,
    required this.stepCount,
  }) : super(id: id, date: date);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': date.toString(),
      'stepCount': stepCount,
    };

    if (super.id != null) {
      map['id'] = super.id;
    }

    return map;
  }

  factory StepTracker.fromMap(Map<String, dynamic> map) {
    return StepTracker(
        id: map['id'] ?? 0,
        date: DateTime.parse(map['date']),
        stepCount: map['stepCount']);
  }

  @override
  String toString() {
    return 'StepTracker(id: ${super.id} date: ${super.date} countStep: $stepCount)';
  }
}
