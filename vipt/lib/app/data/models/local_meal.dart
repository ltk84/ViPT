class LocalMeal {
  final int? id;
  final String name;
  final double calories;
  final double carbs;
  final double protein;
  final double fat;

  LocalMeal({
    this.id,
    required this.name,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });

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

  factory LocalMeal.fromMap(Map<String, dynamic> map) {
    return LocalMeal(
      id: map['id']?.toInt() ?? 0,
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
