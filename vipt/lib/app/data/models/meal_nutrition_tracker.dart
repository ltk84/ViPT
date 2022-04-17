import 'package:vipt/app/data/models/tracker.dart';

class MealNutritionTracker extends Tracker {
  int intakeCalories;
  int outtakeCalories;
  late num diffCalories;

  MealNutritionTracker({
    int? id,
    required DateTime date,
    required this.intakeCalories,
    required this.outtakeCalories,
  }) : super(id: id, date: date) {
    diffCalories = intakeCalories - outtakeCalories;
  }

  void updateIntake(int intake) {
    intakeCalories = intake;
    diffCalories = intakeCalories - outtakeCalories;
  }

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': super.date.toString(),
      'intakeCalories': intakeCalories,
      'outtakeCalories': outtakeCalories,
    };

    if (super.id != null) {
      map['id'] = super.id;
    }

    return map;
  }

  factory MealNutritionTracker.fromMap(Map<String, dynamic> map) {
    return MealNutritionTracker(
      id: map['id'],
      date: map['date'],
      intakeCalories: map['intakeCalories'] ?? 0,
      outtakeCalories: map['outtakeCalories'] ?? 0,
    );
  }
}
