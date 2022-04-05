import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/data/models/meal.dart';

class MealCollection extends BaseModel {
  final String title;
  final String description;
  final String note;
  final String asset;
  final Map<int, List<String>> dateToMealID;

  MealCollection(
      {required String id,
      required this.title,
      required this.description,
      required this.note,
      required this.asset,
      required this.dateToMealID})
      : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'note': note,
      'asset': asset,
      'dateToMeal': dateToMealID,
    };
  }

  factory MealCollection.fromMap(String id, Map<String, dynamic> map) {
    return MealCollection(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      note: map['note'] ?? '',
      asset: map['asset'] ?? '',
      dateToMealID: map['dateToMeal'],
    );
  }
}
