import 'package:vipt/app/data/models/base_model.dart';

class Ingredient extends BaseModel {
  final String name;
  final num amount;

  Ingredient({
    required String id,
    required this.name,
    required this.amount,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'amount': amount,
    };
  }

  factory Ingredient.fromMap(String id, Map<String, dynamic> map) {
    return Ingredient(
      id: id,
      name: map['name'] ?? '',
      amount: map['amount'] ?? 0,
    );
  }

  @override
  String toString() => 'Ingredient(name: $name, amount: $amount)';
}
