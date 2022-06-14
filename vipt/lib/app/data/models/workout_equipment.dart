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
      'name': name,
      'imageLink': imageLink,
    };
  }

  factory WorkoutEquipment.fromMap(String? id, Map<String, dynamic> map) {
    return WorkoutEquipment(
      id ?? '',
      name: map['name'] ?? '',
      imageLink: map['imageLink'] ?? '',
    );
  }
}
