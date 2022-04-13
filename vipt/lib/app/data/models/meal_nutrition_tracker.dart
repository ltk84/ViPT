import 'package:vipt/app/data/models/tracker.dart';

class MealNutritionTracker extends Tracker {
  num intakeCalories;
  num outtakeCalories;
  late num diffCalories;

  MealNutritionTracker({
    required DateTime date,
    required this.intakeCalories,
    required this.outtakeCalories,
  }) : super(date) {
    diffCalories = intakeCalories - outtakeCalories;
  }

  void updateIntake(num intake) {
    intakeCalories = intake;
    diffCalories = intakeCalories - outtakeCalories;
  }

  @override
  void updateToDB() {
    // TODO: implement updateToDB
  }
}
