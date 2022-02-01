import 'dart:convert';

import 'package:vipt/app/data/models/base_model.dart';

class WorkoutEquipment extends BaseModel {
  final String name;
  final String imageLink;

  WorkoutEquipment(
    String? id, {
    required this.name,
    required this.imageLink,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageLink': imageLink,
    };
  }

  factory WorkoutEquipment.fromMap(Map<String, dynamic> map) {
    return WorkoutEquipment(
      map['id'] ?? '',
      name: map['name'] ?? '',
      imageLink: map['imageLink'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkoutEquipment.fromJson(String source) =>
      WorkoutEquipment.fromMap(json.decode(source));
}
