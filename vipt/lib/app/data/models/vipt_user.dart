import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vipt/app/data/models/base_model.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/enums/enum_serialize.dart';

class ViPTUser extends BaseModel {
  String name;
  Gender gender;
  DateTime dateOfBirth;
  num currentWeight;
  num currentHeight;
  num goalWeight;
  WeightUnit weightUnit;
  HeightUnit heightUnit;
  List<Hobby>? hobbies;
  Diet diet;
  BadHabit? badHabit;
  ProteinSource proteinSource;
  List<PhyscialLimitaion>? limits;
  SleepTime sleepTime;
  DailyWater dailyWater;
  MainGoal mainGoal;
  BodyType bodyType;
  Experience experience;
  TypicalDay typicalDay;
  ActiveFrequency activeFrequency;

  ViPTUser({
    required String id,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.currentWeight,
    required this.currentHeight,
    required this.goalWeight,
    required this.weightUnit,
    required this.heightUnit,
    required this.hobbies,
    required this.diet,
    required this.badHabit,
    required this.proteinSource,
    required this.limits,
    required this.sleepTime,
    required this.dailyWater,
    required this.mainGoal,
    required this.bodyType,
    required this.experience,
    required this.typicalDay,
    required this.activeFrequency,
  }) : super(id);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender.toStr(),
      'dateOfBirth': dateOfBirth,
      'currentWeight': currentWeight,
      'currentHeight': currentHeight,
      'goalWeight': goalWeight,
      'weightUnit': weightUnit.toStr(),
      'heightUnit': heightUnit.toStr(),
      'hobbies': hobbies!.map((e) => e.toStr()).toList(),
      'diet': diet.toStr(),
      'badHabit': badHabit?.toStr(),
      'proteinSource': proteinSource.toStr(),
      'limits': limits!.map((e) => e.toStr()).toList(),
      'sleepTime': sleepTime.toStr(),
      'dailyWater': dailyWater.toStr(),
      'mainGoal': mainGoal.toStr(),
      'bodyType': bodyType.toStr(),
      'experience': experience.toStr(),
      'typicalDay': typicalDay.toStr(),
      'activeFrequency': activeFrequency.toStr(),
    };
  }

  factory ViPTUser.fromMap(Map<String, dynamic> data) {
    Iterable hobbies = data['hobbies'];
    Iterable limits = data['limits'];
    return ViPTUser(
      id: data['id'],
      name: data['name'],
      gender: GenderFormat.fromStr(data['gender']),
      dateOfBirth: (data['dateOfBirth'] as Timestamp).toDate(),
      currentWeight: data['currentWeight'],
      currentHeight: data['currentHeight'],
      goalWeight: data['goalWeight'],
      weightUnit: WeightUnitFormat.fromStr(data['weightUnit']),
      heightUnit: HeightUnitFormat.fromStr(data['heightUnit']),
      hobbies: List<Hobby>.from(hobbies.isEmpty
          ? [Hobby.none]
          : hobbies.map((x) => HobbyFormat.fromStr(x))),
      diet: DietFormat.fromStr(data['diet']),
      badHabit: BadHabitFormat.fromStr(data['badHabit'] ?? 'none'),
      proteinSource: ProteinSourceFormat.fromStr(data['proteinSource']),
      limits: List<PhyscialLimitaion>.from(limits.isEmpty
          ? [PhyscialLimitaion.none]
          : limits.map((x) => PhyscialLimitationFormat.fromStr(x))),
      sleepTime: SleepTimeFormat.fromStr(data['sleepTime']),
      dailyWater: DailyWaterFormat.fromStr(data['dailyWater']),
      mainGoal: MainGoalFormat.fromStr(data['mainGoal']),
      bodyType: BodyTypeFormat.fromStr(data['bodyType']),
      experience: ExperienceFormat.fromStr(data['experience']),
      typicalDay: TypicalDayFormat.fromStr(data['typicalDay']),
      activeFrequency: ActiveFrequencyFormat.fromStr(data['activeFrequency']),
    );
  }
}
