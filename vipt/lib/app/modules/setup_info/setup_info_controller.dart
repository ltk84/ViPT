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
  late Map<Question, List<Answer>> _data;
  late Map<int, int> _moduleMap;
  late List<double> progressList;
  late int index;

  late TextEditingController textFieldControllerForMeasureLayout;
  late TextEditingController textFieldControllerForTextFieldLayout;
  late int? toggleValueForMeasureLayout;
  late DateTime? dateTimeForDateTimeLayout;

  late String name;
  late Gender gender;
  late DateTime dateOfBirth;
  late num currentHeight;
  late num currentWeight;
  num? goalWeight;
  late WeightUnit weightUnit;
  late HeightUnit heightUnit;
  Hobby? hobby;
  late String trainFrequency;
  late PhyscialLimitaion limit;
  late int sleepTime;
  Diet? diet;
  BadHabit? badHabit;
  ProteinSource? proteinSource;
  late String dailyWater;

  @override
  void onInit() {
    super.onInit();
    _data = AppQuiz.questions;
    _moduleMap = AppQuiz.moduleMap;
    index = 0;
    progressList = List.generate(_moduleMap.length, (index) => 0);
    _updateProgressList();

    textFieldControllerForMeasureLayout = TextEditingController();
    textFieldControllerForTextFieldLayout = TextEditingController();
    toggleValueForMeasureLayout = 0;
    dateTimeForDateTimeLayout = DateTime.now();

    name = '';
    gender = Gender.male;
    dateOfBirth = DateTime.now();
    currentHeight = 0;
    currentWeight = 0;
    weightUnit = WeightUnit.kg;
    heightUnit = HeightUnit.cm;
    trainFrequency = '';
    limit = PhyscialLimitaion.none;
    sleepTime = 0;
    dailyWater = '';
    goalWeight = 0;
    hobby = Hobby.fighting;
    diet = Diet.holiday;
    badHabit = BadHabit.drinkMuchBeer;
    proteinSource = ProteinSource.chickenBreast;
  }

  void _onConfirm() {
    if (index == 0) {
      if (toggleValueForMeasureLayout == 0) {
        weightUnit = WeightUnit.kg;
      } else {
        weightUnit = WeightUnit.lbs;
      }

      currentWeight = num.parse(textFieldControllerForMeasureLayout.text);
    } else if (index == _data.length - 1) {
      finishSetupBasicInformation();
    }

    textFieldControllerForMeasureLayout.clear();
    toggleValueForMeasureLayout = 0;
  }

  _beforBack() {
    if (index == 0) {
      textFieldControllerForMeasureLayout.text = currentWeight.toString();
      weightUnit == WeightUnit.kg ? 0 : 1;
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
    }
    _updateProgressList();
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

  Future<void> finishSetupBasicInformation() async {
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
