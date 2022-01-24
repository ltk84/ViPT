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
  TextEditingController textFieldControllerForDatePickerLayout =
      TextEditingController();
  int? toggleValueForMeasureLayout = 0;

  String? groupValue;

  String? name;
  Gender? gender;
  DateTime? dateOfBirth;
  num? currentHeight;
  num? currentWeight;
  num? goalWeight;
  WeightUnit? weightUnit;
  HeightUnit? heightUnit;
  Hobby? hobby;
  String? trainFrequency;
  PhyscialLimitaion? limit;
  int? sleepTime;
  Diet? diet;
  BadHabit? badHabit;
  ProteinSource? proteinSource;
  String? dailyWater;

  DateTime? testDate;

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

  void _passValueForDatePickerLayout(String dateTime) {
    textFieldControllerForDatePickerLayout.text = dateTime;
  }

  void _passValueForTextFieldLayout(String text) {
    textFieldControllerForTextFieldLayout.text = text;
  }

  void _clearValueForMeasurementLayout() {
    textFieldControllerForMeasureLayout.clear();
    toggleValueForMeasureLayout = 0;
  }

  void _clearValueForDatePickerLayout() {
    textFieldControllerForDatePickerLayout.clear();
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
    textFieldControllerForDatePickerLayout.text = inputDateTime.toString();
    update();
  }

  void handleOnUnitChange(int? value) {
    toggleValueForMeasureLayout = value;
    update();
  }

  void _setValueForUserProperty() {
    // if (index == 0) {
    //   weightUnit =
    //       toggleValueForMeasureLayout == 0 ? WeightUnit.kg : WeightUnit.lbs;
    //   if (textFieldControllerForMeasureLayout.text.isNotEmpty) {
    //     currentWeight = num.parse(textFieldControllerForMeasureLayout.text);
    //   }
    // } else if (index == 1) {
    //   name = textFieldControllerForTextFieldLayout.text;
    // } else if (index == 2) {
    //   dateOfBirth = dateTimeForDateTimeLayout as DateTime;
    // }

    if (index == 0) {
      dateOfBirth = DateTime.parse(textFieldControllerForDatePickerLayout.text);
    } else if (index == 1) {
      testDate = DateTime.parse(textFieldControllerForDatePickerLayout.text);
    }

    _clearValueOfFixedControlBaseOnLayoutType(getCurrentQuestion().layoutType);
  }

  void _setValueForFixedControl() {
    var currentLayout = getCurrentQuestion().layoutType;
    // if (index == 0) {
    //   _passValueForFixedControlBaseOnLayoutType(currentLayout,
    //       [weightUnit == WeightUnit.kg ? 0 : 1, currentWeight.toString()]);
    // } else if (index == 1) {
    //   _passValueForFixedControlBaseOnLayoutType(currentLayout, [name]);
    // } else if (index == 2) {
    //   _passValueForFixedControlBaseOnLayoutType(currentLayout, [dateOfBirth]);
    // }
    if (index == 0) {
      _passValueForFixedControlBaseOnLayoutType(currentLayout, [dateOfBirth]);
    } else if (index == 1) {
      _passValueForFixedControlBaseOnLayoutType(currentLayout, [testDate]);
    }
  }

  void _passValueForFixedControlBaseOnLayoutType(
      QuestionLayoutType type, List<dynamic> data) {
    switch (type) {
      case QuestionLayoutType.datePicker:
        _passValueForDatePickerLayout(data[0].toString());
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

  void _setupForFixedControlBeforeGoToNextQuestion() {
    QuestionLayoutType type = getCurrentQuestion().layoutType;
    if (index == 1 && testDate != null) {
      _passValueForFixedControlBaseOnLayoutType(type, [testDate]);
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
    _setValueForUserProperty();
    if (index < _data.length - 1) {
      index++;
      _updateProgressList();
      _setupForFixedControlBeforeGoToNextQuestion();
    } else {
      _finishSetupBasicInformation();
    }
    update();
  }

  void goToPreviousQuestion() {
    if (index > 0) {
      index--;
    }
    _setValueForFixedControl();
    _updateProgressList(action: 'back');
    update();
  }

  Future<void> _finishSetupBasicInformation() async {
    // create user voi thong tin cung cap tu quiz
    ViPTUser newUser = ViPTUser(
        id: AuthService.instance.currentUser!.uid,
        name: name as String,
        gender: gender as Gender,
        dateOfBirth: dateOfBirth as DateTime,
        currentWeight: currentWeight as num,
        currentHeight: currentHeight as num,
        weightUnit: weightUnit as WeightUnit,
        heightUnit: heightUnit as HeightUnit,
        trainFrequency: trainFrequency as String,
        limit: limit as PhyscialLimitaion,
        sleepTime: sleepTime as int,
        badHabit: badHabit,
        diet: diet,
        goalWeight: goalWeight,
        hobby: hobby,
        proteinSource: proteinSource,
        dailyWater: dailyWater as String);

    await DataService.instance.createUser(newUser);

    Get.offAllNamed(Routes.home);
  }
}
