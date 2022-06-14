import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/data/models/component.dart';

class Meal extends BaseModel implements Component {
  final String name;
  final String asset;
  final int cookTime;
  final Map<String, String> ingreIDToAmount;
  final List<String> steps;
  final List<String> categoryIDs;

  Meal({
    required String id,
    required this.name,
    required this.asset,
    required this.cookTime,
    required this.ingreIDToAmount,
    required this.steps,
    required this.categoryIDs,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'asset': asset,
      'cookTime': cookTime,
      'ingreIDToAmount': ingreIDToAmount,
      'steps': steps,
      'categoryIDs': categoryIDs,
    };
  }

  factory Meal.fromMap(String id, Map<String, dynamic> map) {
    return Meal(
      id: id,
      name: map['name'] ?? '',
      asset: map['asset'] ?? '',
      cookTime: map['cookTime']?.toInt() ?? 0,
      ingreIDToAmount: Map<String, String>.from(map['ingreIDToAmount']),
      steps: List<String>.from(map['steps']),
      categoryIDs: List<String>.from(map['categoryIDs']),
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
