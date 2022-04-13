import 'package:vipt/app/data/models/tracker.dart';

class ExerciseTracker extends Tracker {
  num outtakeCalories;
  int sessionNumber;
  num totalTime;

  ExerciseTracker({
    required DateTime date,
    required this.outtakeCalories,
    required this.sessionNumber,
    required this.totalTime,
  }) : super(date);

  @override
  void updateToDB() {
    // TODO: implement updateToDB
  }
}
