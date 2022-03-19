import 'package:vipt/app/data/models/base_model.dart';

class Meal extends BaseModel {
  final String name;
  final String backgroundImage;
  final String thumbnail;
  final num kcal;
  final num protein;
  final num fat;
  final num carbs;
  final int cookTime;
  final String note;
  final List<String> ingredientIDs;
  final List<String> steps;
  Meal({
    required String id,
    required this.name,
    required this.backgroundImage,
    required this.thumbnail,
    required this.kcal,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.cookTime,
    required this.note,
    required this.ingredientIDs,
    required this.steps,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'backgroundImage': backgroundImage,
      'thumbnail': thumbnail,
      'kcal': kcal,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
      'cookTime': cookTime,
      'note': note,
      'ingredientIDs': ingredientIDs,
      'steps': steps,
    };
  }

  factory Meal.fromMap(String id, Map<String, dynamic> map) {
    return Meal(
      id: id,
      name: map['name'] ?? '',
      backgroundImage: map['backgroundImage'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      kcal: map['kcal'] ?? 0,
      protein: map['protein'] ?? 0,
      fat: map['fat'] ?? 0,
      carbs: map['carbs'] ?? 0,
      cookTime: map['cookTime']?.toInt() ?? 0,
      note: map['note'] ?? '',
      ingredientIDs: List<String>.from(map['ingredientIDs']),
      steps: List<String>.from(map['steps']),
    );
  }

  @override
  String toString() {
    return 'Meal(name: $name, backgroundImage: $backgroundImage, thumbnail: $thumbnail, kcal: $kcal, protein: $protein, fat: $fat, carbs: $carbs, cookTime: $cookTime, note: $note, ingredientIDs: $ingredientIDs, steps: $steps)';
  }
}
