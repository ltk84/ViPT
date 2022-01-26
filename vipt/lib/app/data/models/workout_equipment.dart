import 'package:vipt/app/data/models/base_model.dart';

class WorkoutEquipment extends BaseModel {
  final String name;
  final String imageLink;

  WorkoutEquipment({
    required String id,
    required this.name,
    required this.imageLink,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
