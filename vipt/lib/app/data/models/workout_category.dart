import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/enums/enum_serialize.dart';

class WorkoutCategory extends BaseModel {
  final String name;
  final String imageLink;
  final CategoryType categoryType;

  WorkoutCategory(
    String? id, {
    required this.name,
    required this.imageLink,
    required this.categoryType,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageLink': imageLink,
      'categoryType': categoryType.toStr(),
    };
  }

  factory WorkoutCategory.fromMap(Map<String, dynamic> data) {
    return WorkoutCategory(data['id'],
        name: data['name'],
        imageLink: data['imageLink'],
        categoryType: CategoryTypeFormat.fromStr(data['categoryType']));
  }
}
