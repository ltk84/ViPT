import 'package:vipt/app/data/models/nutrition.dart';

class LocalMealNutrition extends Nutrition {
  final String name;

  LocalMealNutrition({
    String? id,
    required this.name,
    num calories = 0,
    num carbs = 0,
    num fat = 0,
    num protein = 0,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'name': name,
      'calories': calories,
      'carbs': carbs,
      'protein': protein,
      'fat': fat,
    };

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory LocalMealNutrition.fromMap(Map<String, dynamic> map) {
    return LocalMealNutrition(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      calories: map['calories']?.toDouble() ?? 0.0,
      carbs: map['carbs']?.toDouble() ?? 0.0,
      protein: map['protein']?.toDouble() ?? 0.0,
      fat: map['fat']?.toDouble() ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'LocalMeal(id: $id, name: $name, calories: $calories, carbs: $carbs, protein: $protein, fat: $fat)';
  }
}
