import 'package:collection/collection.dart';
import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/data/models/component.dart';

class WorkoutCollection extends BaseModel implements Component {
  final String title;
  final String description;
  final String asset;
  final List<String> generatorIDs;
  final List<String> categoryIDs;

  WorkoutCollection(
    String? id, {
    required this.title,
    required this.description,
    required this.asset,
    required this.generatorIDs,
    required this.categoryIDs,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'generatorIDs': generatorIDs,
      'categoryIDs': categoryIDs,
    };
  }

  factory WorkoutCollection.fromMap(String id, Map<String, dynamic> map) {
    return WorkoutCollection(
      id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      asset: map['asset'] ?? '',
      generatorIDs: List<String>.from(map['generatorIDs'] ?? []),
      categoryIDs: List<String>.from(map['categoryIDs'] ?? []),
    );
  }

  @override
  String toString() {
    return 'WorkoutCollection(title: $title, description: $description, asset: $asset, generatorIDs: $generatorIDs, categoryIDs: $categoryIDs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is WorkoutCollection &&
        other.title == title &&
        other.description == description &&
        other.asset == asset &&
        listEquals(other.generatorIDs, generatorIDs) &&
        listEquals(other.categoryIDs, categoryIDs);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        asset.hashCode ^
        generatorIDs.hashCode ^
        categoryIDs.hashCode;
  }

  @override
  int countLeaf() {
    return 1;
  }

  @override
  bool isComposite() {
    return false;
  }
}
