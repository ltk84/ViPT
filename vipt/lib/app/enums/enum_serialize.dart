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

extension HobbyToString on Hobby {
  String toStr() => toString().split('.').last;
  static Hobby fromStr(String string) =>
      Hobby.values.firstWhere((e) => e.toStr() == string);
}

extension BodyTypeToString on BodyType {
  String toStr() => toString().split('.').last;
  static BodyType fromStr(String string) =>
      BodyType.values.firstWhere((e) => e.toStr() == string);
}

extension TypicalDayToString on TypicalDay {
  String toStr() => toString().split('.').last;
  static TypicalDay fromStr(String string) =>
      TypicalDay.values.firstWhere((e) => e.toStr() == string);
}

const Map<int, String> _freqValueMap = {
  0: "Không nhiều",
  1: "1-2 ngày/tuần",
  2: "3-5 ngày/tuần",
  3: "5-7 ngày/tuần",
};

extension FrequencyFormat on int {
  String toFreqStringValue() => _freqValueMap[this] as String;
}
