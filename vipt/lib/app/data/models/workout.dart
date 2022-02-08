import 'dart:convert';

import 'package:vipt/app/data/models/base_model.dart';

class Workout extends BaseModel {
  final String name;
  final String animation;
  final String hints;
  final String breathing;
  final String muscleFocusAsset;
  final List<String> categoryIDs;
  final num metValue;
  final List<String> equipmentIDs;

  Workout(
    String? id, {
    required this.name,
    required this.animation,
    required this.hints,
    required this.breathing,
    required this.muscleFocusAsset,
    required this.categoryIDs,
    required this.metValue,
    required this.equipmentIDs,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'animation': animation,
      'hints': hints,
      'breathing': breathing,
      'muscleFocusAsset': muscleFocusAsset,
      'categoryIDs': categoryIDs,
      'metValue': metValue,
      'equipmentIDs': equipmentIDs,
    };
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source));

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      map['id'] ?? '',
      name: map['name'] ?? '',
      animation: map['animation'] ?? '',
      hints: map['hints'] ?? '',
      breathing: map['breathing'] ?? '',
      muscleFocusAsset: map['muscleFocusAsset'] ?? '',
      categoryIDs: List<String>.from(map['categoryIDs']),
      metValue: map['metValue'] ?? 0,
      equipmentIDs: List<String>.from(map['equipmentIDs']),
    );
  }
}