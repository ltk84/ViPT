import 'package:vipt/app/data/models/tracker.dart';

class ExerciseTracker extends Tracker {
  int outtakeCalories;
  int sessionNumber;
  int totalTime;

  ExerciseTracker({
    int? id,
    required DateTime date,
    required this.outtakeCalories,
    required this.sessionNumber,
    required this.totalTime,
  }) : super(id: id, date: date);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': super.date,
      'outtakeCalories': outtakeCalories,
      'sessionNumber': sessionNumber,
      'totalTime': totalTime,
    };

    if (super.id != null) {
      map['id'] = super.id;
    }

    return map;
  }

  factory ExerciseTracker.fromMap(Map<String, dynamic> map) {
    return ExerciseTracker(
      id: map['id'],
      date: map['date'],
      outtakeCalories: map['outtakeCalories'] ?? 0,
      sessionNumber: map['sessionNumber']?.toInt() ?? 0,
      totalTime: map['totalTime'] ?? 0,
    );
  }
}
