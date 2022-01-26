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
    throw UnimplementedError();
  }
}
