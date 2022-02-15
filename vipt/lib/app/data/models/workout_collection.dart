import 'package:collection/collection.dart';
import 'package:vipt/app/data/models/base_model.dart';

class WorkoutCollection extends BaseModel {
  final String title;
  final String description;
  final List<String> workoutIDs;
  final List<String> categoryIDs;

  WorkoutCollection(
    String? id, {
    required this.title,
    required this.description,
    required this.workoutIDs,
    required this.categoryIDs,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'workoutIDs': workoutIDs,
      'categoryIDs': categoryIDs,
    };
  }

  factory WorkoutCollection.fromMap(String id, Map<String, dynamic> map) {
    return WorkoutCollection(
      id,
      title: map['title'] ?? '',
      description: map['description'],
      workoutIDs: List<String>.from(map['workoutIDs']),
      categoryIDs: List<String>.from(map['categoryIDs']),
    );
  }

  @override
  String toString() {
    return 'WorkoutCollection(title: $title, description: $description, workoutIDs: $workoutIDs, categoryIDs: $categoryIDs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WorkoutCollection &&
        other.title == title &&
        other.description == description &&
        listEquals(other.workoutIDs, workoutIDs) &&
        listEquals(other.categoryIDs, categoryIDs);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        workoutIDs.hashCode ^
        categoryIDs.hashCode;
  }
}