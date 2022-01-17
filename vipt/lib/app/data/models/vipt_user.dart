import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/enums/enum_serialize.dart';

class ViPTUser extends BaseModel {
  String? name;
  Gender gender;
  DateTime dateOfBirth;
  num currentWeight;
  num currentHeight;
  WeightUnit weightUnit;
  HeightUnit heightUnit;
  Hobby hobby;
  int frequency;

  ViPTUser(
    String id, {
    this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.currentWeight,
    required this.currentHeight,
    required this.weightUnit,
    required this.heightUnit,
    required this.hobby,
    required this.frequency,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    throw UnimplementedError();
  }
}
