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

  // fixed control of different type of layout
  TextEditingController textFieldControllerForMeasureLayout =
      TextEditingController();
  TextEditingController textFieldControllerForTextFieldLayout =
      TextEditingController();
  int? toggleValueForMeasureLayout = 0;
  DateTime? dateTimeForDateTimeLayout = DateTime.now();

  String? groupValue;

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

  void handleMultipleSelectAnswer(String title) {
    var selectedAnswer = _data.values
        .elementAt(index)
        .firstWhere((element) => element.title == title);

    selectedAnswer.isSelected = !selectedAnswer.isSelected;
    update();
  }

  void handleSingleSelectAnswer(String value) {
    var selectedAnswer = _data.values
        .elementAt(index)
        .firstWhere((element) => element.title == value);
    if (groupValue == value) {
      groupValue = '';
    } else {
      groupValue = value;
    }
    selectedAnswer.isSelected = !selectedAnswer.isSelected;
    update();
  }

  void handleSelectDateTime(DateTime inputDateTime) {
    textFieldControllerForTextFieldLayout.text = inputDateTime.toString();
    update();
  }

  void handleOnUnitChange(int? value) {
    toggleValueForMeasureLayout = value;
    update();
  }

  void _onConfirm() {
    if (index == 0) {
      weightUnit =
          toggleValueForMeasureLayout == 0 ? WeightUnit.kg : WeightUnit.lbs;
      if (textFieldControllerForMeasureLayout.text.isNotEmpty) {
        currentWeight = num.parse(textFieldControllerForMeasureLayout.text);
      }
    } else if (index == 1) {
      name = textFieldControllerForTextFieldLayout.text;
    } else if (index == 2) {
      dateOfBirth = dateTimeForDateTimeLayout as DateTime;
    }

    _clearValueOfFixedControlBaseOnLayoutType(getCurrentQuestion().layoutType);
  }

  void _beforeBack() {
    var currentLayout = getCurrentQuestion().layoutType;
    if (index == 0) {
      _passValueForFixedControlBaseOnLayoutType(currentLayout,
          [weightUnit == WeightUnit.kg ? 0 : 1, currentWeight.toString()]);
    } else if (index == 1) {
      _passValueForFixedControlBaseOnLayoutType(currentLayout, [name]);
    } else if (index == 2) {
      _passValueForFixedControlBaseOnLayoutType(currentLayout, [dateOfBirth]);
    }
  }

  void _passValueForFixedControlBaseOnLayoutType(
      QuestionLayoutType type, List<dynamic> data) {
    switch (type) {
      case QuestionLayoutType.datePicker:
        _passValueForDatePickerLayout(data[0] as DateTime);
        break;
      case QuestionLayoutType.measurementPicker:
        _passValueForMeasurementLayout(data[0] as int?, data[1] as String);
        break;
      case QuestionLayoutType.multipleChoiceOneColumn:
        break;
      case QuestionLayoutType.multipleChoiceTwoColumns:
        break;
      case QuestionLayoutType.singleChoiceOneColumn:
        break;
      case QuestionLayoutType.singleChoiceTwoColumns:
        break;
      case QuestionLayoutType.textField:
        _passValueForTextFieldLayout(data[0] as String);
        break;
      default:
    }
  }

  void _clearValueOfFixedControlBaseOnLayoutType(QuestionLayoutType type) {
    switch (type) {
      case QuestionLayoutType.datePicker:
        _clearValueForDatePickerLayout();
        break;
      case QuestionLayoutType.measurementPicker:
        _clearValueForMeasurementLayout();
        break;
      case QuestionLayoutType.multipleChoiceOneColumn:
        break;
      case QuestionLayoutType.multipleChoiceTwoColumns:
        break;
      case QuestionLayoutType.singleChoiceOneColumn:
        break;
      case QuestionLayoutType.singleChoiceTwoColumns:
        break;
      case QuestionLayoutType.textField:
        _clearValueForTextFieldLayout();
        break;
      default:
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
    _onConfirm();
    if (index < _data.length - 1) {
      index++;
      _updateProgressList();
    } else {
      _finishSetupBasicInformation();
    }
    update();
  }

  void goToPreviousQuestion() {
    if (index > 0) {
      index--;
    }
    _beforeBack();
    _updateProgressList(action: 'back');
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
