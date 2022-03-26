import 'package:vipt/app/data/models/base_model.dart';

class MealCollection extends BaseModel {
  final String title;
  final String description;
  final String note;
  final String asset;
  final Map<int, String> dateToMeal;

  MealCollection(
      {required String id,
      required this.title,
      required this.description,
      required this.note,
      required this.asset,
      required this.dateToMeal})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'note': note,
      'asset': asset,
      'dateToMeal': dateToMeal,
    };
  }

  factory MealCollection.fromMap(String id, Map<String, dynamic> map) {
    return MealCollection(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      note: map['note'] ?? '',
      asset: map['asset'] ?? '',
      dateToMeal: map['dateToMeal'],
    );
  }
}
