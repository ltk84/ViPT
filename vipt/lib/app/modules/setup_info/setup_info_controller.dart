import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/routes/pages.dart';
import 'package:vipt/app/data/models/question.dart';

class SetupInfoController extends GetxController {
  final Map<Question, List<Answer>> _data = AppQuiz.questions;
  final Map<int, int> _moduleMap = AppQuiz.moduleMap;
  late List<double> progressList;
  int index = 0;

  TextEditingController textFieldControllerForMeasureLayout =
      TextEditingController();
  TextEditingController textFieldControllerForTextFieldLayout =
      TextEditingController();
  int? toggleValueForMeasureLayout;
  DateTime? dateTimeForDateTimeLayout;

  String name = '';
  Gender gender = Gender.male;
  DateTime dateOfBirth = DateTime.now();
  num currentHeight = 0;
  num currentWeight = 0;
  num? goalWeight;
  WeightUnit weightUnit = WeightUnit.kg;
  HeightUnit heightUnit = HeightUnit.cm;
  Hobby? hobby;
  String trainFrequency = '';
  PhyscialLimitaion limit = PhyscialLimitaion.none;
  int sleepTime = 0;
  Diet? diet;
  BadHabit? badHabit;
  ProteinSource? proteinSource;
  String dailyWater = '';

  @override
  void onInit() {
    super.onInit();

    progressList = List.generate(_moduleMap.length, (index) => 0);
    _updateProgressList();

    toggleValueForMeasureLayout = 0;
    dateTimeForDateTimeLayout = DateTime.now();
  }

  void _passValueForMeasurementLayout(int? toggleValue, String textValue) {
    textFieldControllerForMeasureLayout.text = textValue;
    toggleValueForMeasureLayout = toggleValue;
  }

  void _passValueForDatePickerLayout(DateTime dateTime) {
    dateTimeForDateTimeLayout = dateTime;
  }

  void _passValueForTextFieldLayout(String text) {
    textFieldControllerForTextFieldLayout.text = text;
  }

  void _clearValueForMeasurementLayout() {
    textFieldControllerForMeasureLayout.clear();
    toggleValueForMeasureLayout = 0;
  }

  void _clearValueForDatePickerLayout() {
    dateTimeForDateTimeLayout = DateTime.now();
  }

  void _clearValueForTextFieldLayout() {
    textFieldControllerForTextFieldLayout.clear();
  }

  void _onConfirm() {
    if (index == 0) {
      if (toggleValueForMeasureLayout == 0) {
        weightUnit = WeightUnit.kg;
      } else {
        weightUnit = WeightUnit.lbs;
      }
      currentWeight = num.parse(textFieldControllerForMeasureLayout.text);

      _clearValueForMeasurementLayout();
    }
  }

  void _beforBack() {
    if (index == 0) {
      _passValueForMeasurementLayout(
          weightUnit == WeightUnit.kg ? 0 : 1, currentWeight.toString());
    }
  }

  void _updateProgressList({String action = 'next'}) {
    int currentModule = getCurrentQuestion().moduleParent;
    int currentIndexOfModule = getCurrentQuestion().moduleIndex;

    double progress = currentIndexOfModule / (_moduleMap[currentModule] as num);

    progressList[currentModule] = progress;

    if (action == 'back') {
      if (currentModule + 1 < progressList.length) {
        progressList[currentModule + 1] = 0;
      }
    }
  }

  int getModuleCount() {
    return _moduleMap.length;
  }

  Question getCurrentQuestion() {
    return _data.keys.elementAt(index);
  }

  List<Answer> getCurrentAnswer() {
    return _data.values.elementAt(index);
  }

  void goToNextQuestion() {
    if (index < _data.length - 1) {
      index++;
      _updateProgressList();
    } else {
      _finishSetupBasicInformation();
    }
    _onConfirm();
    update();
  }

  void goToPreviousQuestion() {
    if (index > 0) {
      index--;
    }
    _updateProgressList(action: 'back');
    _beforBack();
    update();
  }

  Future<void> _finishSetupBasicInformation() async {
    // create user voi thong tin cung cap tu quiz
    ViPTUser newUser = ViPTUser(
        id: AuthService.instance.currentUser!.uid,
        name: name,
        gender: gender,
        dateOfBirth: dateOfBirth,
        currentWeight: currentWeight,
        currentHeight: currentHeight,
        weightUnit: weightUnit,
        heightUnit: heightUnit,
        trainFrequency: trainFrequency,
        limit: limit,
        sleepTime: sleepTime,
        badHabit: badHabit,
        diet: diet,
        goalWeight: goalWeight,
        hobby: hobby,
        proteinSource: proteinSource,
        dailyWater: dailyWater);
    await DataService.instance.createUser(newUser);

    Get.offAllNamed(Routes.home);
  }
}
