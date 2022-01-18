import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/enums/enum_serialize.dart';

class ViPTUser extends BaseModel {
  String name;
  Gender gender;
  DateTime dateOfBirth;
  num currentWeight;
  num currentHeight;
  WeightUnit weightUnit;
  HeightUnit heightUnit;
  Hobby hobby;
  String trainFrequency;
  PhyscialLimitaion limit;
  int sleepTime;
  Diet diet;
  BadHabit badHabit;
  ProteinSource proteinSource;
  String dailyWater;

  ViPTUser(
    String id, {
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.currentWeight,
    required this.currentHeight,
    required this.weightUnit,
    required this.heightUnit,
    required this.hobby,
    required this.trainFrequency,
    required this.limit,
    required this.sleepTime,
    required this.diet,
    required this.badHabit,
    required this.proteinSource,
    required this.dailyWater,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'gender': gender.toStr(),
      'dateOfBirth': dateOfBirth,
      'currentWeight': currentWeight,
      'currentHeight': currentHeight,
      'weightUnit': weightUnit.toStr(),
      'heightUnit': heightUnit.toStr(),
      'hobby': hobby.toStr(),
      'trainFrequency': trainFrequency,
      'limit': limit.toStr(),
      'sleepTime': sleepTime,
      'diet': diet.toStr(),
      'badHabit': badHabit.toStr(),
      'proteinSource': proteinSource.toStr(),
      'dailyWater': dailyWater,
    };
  }

  factory ViPTUser.fromMap(Map<String, dynamic> data) {
    return ViPTUser(
      data['id'],
      name: data['name'],
      gender: GenderFormat.fromStr(data['gender']),
      dateOfBirth: data['dateOfBirth'],
      currentWeight: data['currentWeight'],
      currentHeight: data['currentHeight'],
      weightUnit: WeightUnitFormat.fromStr(data['weightUnit']),
      heightUnit: HeightUnitFormat.fromStr(data['heightUnit']),
      hobby: HobbyFormat.fromStr(data['hobby']),
      trainFrequency: data['trainFrequency'],
      limit: PhyscialLimitationFormat.fromStr(data['limit']),
      sleepTime: data['sleepTime'],
      diet: DietFormat.fromStr(data['diet']),
      badHabit: BadHabitFormat.fromStr(data['badHabit']),
      proteinSource: ProteinSourceFormat.fromStr(data['proteinSource']),
      dailyWater: data['dailyWater)'],
    );
  }
}
