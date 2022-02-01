import 'dart:convert';

import 'package:vipt/app/data/models/base_model.dart';

class Workout extends BaseModel {
  final String name;
  final String animationLink;
  final String hints;
  final String breathing;
  final String muscleFocusImageLink;
  final List<String> categoryIDs;
  final int calo;
  final int time;
  final List<String> equipmentIDs;

  Workout(
    String? id, {
    required this.name,
    required this.animationLink,
    required this.hints,
    required this.breathing,
    required this.muscleFocusImageLink,
    required this.categoryIDs,
    required this.calo,
    required this.time,
    required this.equipmentIDs,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'animationLink': animationLink,
      'hints': hints,
      'breathing': breathing,
      'muscleFocusImageLink': muscleFocusImageLink,
      'categoryIDs': categoryIDs,
      'calo': calo,
      'time': time,
      'equipmentIDs': equipmentIDs,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      map['id'] ?? '',
      name: map['name'] ?? '',
      animationLink: map['animationLink'] ?? '',
      hints: map['hints'] ?? '',
      breathing: map['breathing'] ?? '',
      muscleFocusImageLink: map['muscleFocusImageLink'] ?? '',
      categoryIDs: List<String>.from(map['categoryIDs']),
      calo: map['calo']?.toInt() ?? 0,
      time: map['time']?.toInt() ?? 0,
      equipmentIDs: List<String>.from(map['equipmentIDs']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source));
}
