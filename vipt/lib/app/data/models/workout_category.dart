import 'package:vipt/app/data/models/base_model.dart';

class Category extends BaseModel {
  final String name;
  final String asset;
  final String? parentCategoryID;

  Category(
    String? id, {
    required this.name,
    required this.asset,
    required this.parentCategoryID,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'asset': asset,
      'parentCategoryID': parentCategoryID,
    };
  }

  factory Category.fromMap(String id, Map<String, dynamic> data) {
    return Category(
      id,
      name: data['name'],
      asset: data['asset'],
      parentCategoryID: data['parentCategoryID'],
    );
  }

  bool isRootCategory() => parentCategoryID == null;
}
