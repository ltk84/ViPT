import 'package:vipt/app/data/models/base_model.dart';

class MealCollection extends BaseModel {
  final String title;
  final String description;
  final String note;
  final String asset;
  final Map<String, List<String>> dateToMealID;

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
      'dateToMealID': dateToMealID,
    };
  }

  factory MealCollection.fromMap(String id, Map<String, dynamic> map) {
    Map<String, List<String>> dateToMealID = {
      for (var data in (map['dateToMealID'] as Map<String, dynamic>).entries)
        data.key: List<String>.from(data.value)
    };

    return MealCollection(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      note: map['note'] ?? '',
      asset: map['asset'] ?? '',
      dateToMealID: dateToMealID,
    );
  }
}
