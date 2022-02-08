import 'package:vipt/app/data/models/base_model.dart';

class WorkoutCategory extends BaseModel {
  final String name;
  final String asset;
  final String parentCategoryID;

  WorkoutCategory(
    String? id, {
    required this.name,
    required this.asset,
    required this.parentCategoryID,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imageLink': asset,
      'parentCategoryID': parentCategoryID,
    };
  }

  factory WorkoutCategory.fromMap(Map<String, dynamic> data) {
    return WorkoutCategory(
      data['id'],
      name: data['name'],
      asset: data['imageLink'],
      parentCategoryID: data['parentCategoryID'],
    );
  }
}
