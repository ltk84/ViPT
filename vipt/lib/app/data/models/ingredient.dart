import 'dart:convert';

import 'package:vipt/app/data/models/base_model.dart';

class Ingredient extends BaseModel {
  final String name;
  final num kcal;
  final num fat;
  final num carbs;
  final num protein;

  Ingredient({
    required String id,
    required this.name,
    required this.kcal,
    required this.fat,
    required this.carbs,
    required this.protein,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'kcal': kcal,
      'fat': fat,
      'carbs': carbs,
      'protein': protein,
    };
  }

  factory Ingredient.fromMap(String? id, Map<String, dynamic> map) {
    return Ingredient(
      id: id ?? '',
      name: map['name'] ?? '',
      kcal: map['kcal'] ?? 0,
      fat: map['fat'] ?? 0,
      carbs: map['carbs'] ?? 0,
      protein: map['protein'] ?? 0,
    );
  }
}
