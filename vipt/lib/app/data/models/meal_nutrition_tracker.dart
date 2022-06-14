import 'package:vipt/app/data/models/tracker.dart';

class MealNutritionTracker extends Tracker {
  String name;
  int intakeCalories;
  int carbs;
  int protein;
  int fat;

  MealNutritionTracker({
    int? id,
    required DateTime date,
    required this.name,
    required this.intakeCalories,
    required this.carbs,
    required this.protein,
    required this.fat,
  }) : super(id: id, date: date);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'date': super.date.toString(),
      'name': name,
      'intakeCalories': intakeCalories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
    };

    if (super.id != null) {
      map['id'] = super.id;
    }

    return map;
  }

  factory MealNutritionTracker.fromMap(Map<String, dynamic> map) {
    return MealNutritionTracker(
      id: map['id'],
      date: DateTime.parse(map['date']),
      name: map['name'],
      intakeCalories: map['intakeCalories'] ?? 0,
      carbs: map['carbs'] ?? 0,
      protein: map['protein'] ?? 0,
      fat: map['fat'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'MealNutritionTracker(id: $id, date: $date, name: $name, intakeCalories: $intakeCalories, carbs: $carbs, protein: $protein, fat: $fat)';
  }
}
