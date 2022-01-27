import 'dart:convert';

import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/models/workout_equipment.dart';

class Workout extends BaseModel {
  final String name;
  final String animationLink;
  final String hints;
  final String breathing;
  final String muscleFocusImageLink;
  final List<WorkoutCategory> categories;
  final int calo;
  final int time;
  final List<WorkoutEquipment> equipment;

  Workout({
    required String id,
    required this.name,
    required this.animationLink,
    required this.hints,
    required this.breathing,
    required this.muscleFocusImageLink,
    required this.categories,
    required this.calo,
    required this.time,
    required this.equipment,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'animationLink': animationLink,
      'hints': hints,
      'breathing': breathing,
      'muscleFocusImageLink': muscleFocusImageLink,
      'categories': categories.map((x) => x.toMap()).toList(),
      'calo': calo,
      'time': time,
      'equipment': equipment.map((x) => x.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      animationLink: map['animationLink'] ?? '',
      hints: map['hints'] ?? '',
      breathing: map['breathing'] ?? '',
      muscleFocusImageLink: map['muscleFocusImageLink'] ?? '',
      categories: List<WorkoutCategory>.from(
          map['categories']?.map((x) => WorkoutCategory.fromMap(x))),
      calo: map['calo']?.toInt() ?? 0,
      time: map['time']?.toInt() ?? 0,
      equipment: List<WorkoutEquipment>.from(
          map['equipment']?.map((x) => WorkoutEquipment.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source));
}
