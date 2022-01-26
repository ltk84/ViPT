import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/enums/app_enums.dart';

class WorkoutCategory extends BaseModel {
  final String name;
  final String imageLink;
  final CategoryType categoryType;

  WorkoutCategory({
    required String id,
    required this.name,
    required this.imageLink,
    required this.categoryType,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
