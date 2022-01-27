import 'package:vipt/app/data/models/workout_category.dart';

import 'app_enums.dart';

extension GenderFormat on Gender {
  String toStr() => toString().split('.').last;
  static Gender fromStr(String string) => Gender.values.firstWhere(
        (gender) => gender.toStr() == string,
        orElse: () => Gender.male,
      );
}

extension WeightUnitFormat on WeightUnit {
  String toStr() => toString().split('.').last;
  static WeightUnit fromStr(String string) =>
      WeightUnit.values.firstWhere((wu) => wu.toStr() == string);
}

extension HeightUnitFormat on HeightUnit {
  String toStr() => toString().split('.').last;
  static HeightUnit fromStr(String string) =>
      HeightUnit.values.firstWhere((hu) => hu.toStr() == string);
}

extension HobbyFormat on Hobby {
  String toStr() => toString().split('.').last;
  static Hobby fromStr(String string) =>
      Hobby.values.firstWhere((e) => e.toStr() == string);
}

extension BodyTypeFormat on BodyType {
  String toStr() => toString().split('.').last;
  static BodyType fromStr(String string) =>
      BodyType.values.firstWhere((e) => e.toStr() == string);
}

extension TypicalDayFormat on TypicalDay {
  String toStr() => toString().split('.').last;
  static TypicalDay fromStr(String string) =>
      TypicalDay.values.firstWhere((e) => e.toStr() == string);
}

extension SleepTimeFormat on SleepTime {
  String toStr() => toString().split('.').last;
  static SleepTime fromStr(String string) =>
      SleepTime.values.firstWhere((e) => e.toStr() == string);
}

extension ExperienceFormat on Experience {
  String toStr() => toString().split('.').last;
  static Experience fromStr(String string) =>
      Experience.values.firstWhere((e) => e.toStr() == string);
}

// const Map<String, int> _trainingFreqMap = {
//   "Không nhiều": 0,
//   "1-2 ngày/tuần": 1,
//   "3-5 ngày/tuần": 2,
//   "5-7 ngày/tuần": 3,
// };

extension ActiveFrequencyFormat on ActiveFrequency {
  String toStr() => toString().split('.').last;
  static ActiveFrequency fromStr(String string) =>
      ActiveFrequency.values.firstWhere((e) => e.toStr() == string);
}

// const Map<String, int> _dailyWaterMap = {
//   'không uống nước': 0,
//   '2 ly/ngày': 1,
//   '2 - 6 ly/ngày': 2,
//   'trên 6 ly/ngày': 3,
// };

extension DailyWaterFormat on DailyWater {
  String toStr() => toString().split('.').last;
  static DailyWater fromStr(String string) =>
      DailyWater.values.firstWhere((e) => e.toStr() == string);
}

extension MainGoalFormat on MainGoal {
  String toStr() => toString().split('.').last;
  static MainGoal fromStr(String string) =>
      MainGoal.values.firstWhere((e) => e.toStr() == string);
}

extension PhyscialLimitationFormat on PhyscialLimitaion {
  String toStr() => toString().split('.').last;
  static PhyscialLimitaion fromStr(String string) =>
      PhyscialLimitaion.values.firstWhere((e) => e.toStr() == string);
}

extension DietFormat on Diet {
  String toStr() => toString().split('.').last;
  static Diet fromStr(String string) =>
      Diet.values.firstWhere((e) => e.toStr() == string);
}

extension BadHabitFormat on BadHabit {
  String toStr() => toString().split('.').last;
  static BadHabit fromStr(String string) =>
      BadHabit.values.firstWhere((e) => e.toStr() == string);
}

extension ProteinSourceFormat on ProteinSource {
  String toStr() => toString().split('.').last;
  static ProteinSource fromStr(String string) =>
      ProteinSource.values.firstWhere((e) => e.toStr() == string);
}

extension CategoryTypeFormat on CategoryType {
  String toStr() => toString().split('.').last;
  static CategoryType fromStr(String string) =>
      CategoryType.values.firstWhere((e) => e.toStr() == string);
}
