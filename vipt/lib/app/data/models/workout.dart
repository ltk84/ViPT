import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/data/models/component.dart';

class Workout extends BaseModel implements Component {
  final String name;
  final String animation;
  final String thumbnail;
  final String hints;
  final String breathing;
  final String muscleFocusAsset;
  final List<String> categoryIDs;
  final num metValue;
  final List<String> equipmentIDs;

  Workout(
    String? id, {
    required this.name,
    required this.animation,
    required this.thumbnail,
    required this.hints,
    required this.breathing,
    required this.muscleFocusAsset,
    required this.categoryIDs,
    required this.metValue,
    required this.equipmentIDs,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'animation': animation,
      'thumbnail': thumbnail,
      'hints': hints,
      'breathing': breathing,
      'muscleFocusAsset': muscleFocusAsset,
      'categoryIDs': categoryIDs,
      'metValue': metValue,
      'equipmentIDs': equipmentIDs,
    };
  }

  factory Workout.fromMap(String id, Map<String, dynamic> map) {
    return Workout(
      id,
      name: map['name'] ?? '',
      animation: map['animation'] ?? '',
      thumbnail: map['thumbnail'] ?? '',
      hints: map['hints'] ?? '',
      breathing: map['breathing'] ?? '',
      muscleFocusAsset: map['muscleFocusAsset'] ?? '',
      categoryIDs: List<String>.from(map['categoryIDs']),
      metValue: map['metValue'] ?? 0,
      equipmentIDs: List<String>.from(map['equipmentIDs']),
    );
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
