import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/core/values/app_strings.dart';
import 'package:vipt/app/core/values/quiz.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/weight_tracker.dart';
import 'package:vipt/app/data/providers/exercise_nutrition_route_provider.dart';
import 'package:vipt/app/data/providers/weight_tracker_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/routes/pages.dart';
import 'package:intl/intl.dart';
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
  dynamic _selectedValueForSingleChoiceLayout;
  List<dynamic> _listSelectedValueForMultipleChoiceLayout = [];
  String? groupValue;
  bool isAbleToGoToNextQuestion = false;
  String? errorTextForTextField;

  String _primaryUnitSymbol = AppString.primaryWeightUnitSymbol;
  String get primaryUnitSymbol => _primaryUnitSymbol;
  set primaryUnitSymbol(String value) {
    _primaryUnitSymbol = value;
    update();
  }

  String _secondaryUnitSymbol = AppString.secondaryWeightUnitSymbol;
  String get secondaryUnitSymbol => _secondaryUnitSymbol;
  set secondaryUnitSymbol(String value) {
    _secondaryUnitSymbol = value;
    update();
  }

  set selectedValueForSingleChoiceLayout(dynamic value) {
    _selectedValueForSingleChoiceLayout = value;
    if (_selectedValueForSingleChoiceLayout == null) {
      isAbleToGoToNextQuestion = false;
    } else {
      isAbleToGoToNextQuestion = true;
    }
    update();
  }

  dynamic get selectedValueForSingleChoiceLayout =>
      _selectedValueForSingleChoiceLayout;

  set listSelectedValueForMultipleChoiceLayout(List<dynamic> listValue) {
    _listSelectedValueForMultipleChoiceLayout = listValue;
    if (_listSelectedValueForMultipleChoiceLayout.isEmpty) {
      isAbleToGoToNextQuestion = false;
    } else {
      isAbleToGoToNextQuestion = true;
    }
    update();
  }

  List<dynamic> get listSelectedValueForMultipleChoiceLayout =>
      _listSelectedValueForMultipleChoiceLayout;

  String? name;
  Gender? gender;
  DateTime? dateOfBirth;
  num? currentHeight;
  num? currentWeight;
  num? goalWeight;
  WeightUnit? weightUnit;
  HeightUnit? heightUnit;
  List<Hobby>? hobbies;
  List<PhyscialLimitaion>? limits;
  SleepTime? sleepTime;
  Diet? diet;
  List<BadHabit>? badHabits;
  List<ProteinSource>? proteinSources;
  DailyWater? dailyWater;
  MainGoal? mainGoal;
  BodyType? bodyType;
  Experience? experience;
  TypicalDay? typicalDay;
  ActiveFrequency? activeFrequency;

  void validateInputForMeasureLayout() {
    String text = textFieldControllerForMeasureLayout.text;

    if (text.isEmpty) {
      isAbleToGoToNextQuestion = false;
      errorTextForTextField = null;
    } else {
      switch (getCurrentQuestion().propertyLink) {
        case PropertyLink.userHeight:
          double? height = double.tryParse(text);
          bool isCm = toggleValueForMeasureLayout == 0 ? true : false;
          if (height != null) {
            if (isCm) {
              if (height >= AppValue.heightCeilInCmValue &&
                  height <= AppValue.heightFloorInCmValue) {
                errorTextForTextField = null;
                isAbleToGoToNextQuestion = true;
                break;
              }
            } else {
              if (height >= AppValue.heightCeilInFtValue &&
                  height <= AppValue.heightFloorInFtValue) {
                errorTextForTextField = null;
                isAbleToGoToNextQuestion = true;
                break;
              }
            }
          }
          errorTextForTextField = '$text không phù hợp';
          isAbleToGoToNextQuestion = false;
          break;
        case PropertyLink.userWeight:
          double? weight = double.tryParse(text);
          bool isKg = toggleValueForMeasureLayout == 0 ? true : false;
          if (weight != null) {
            if (isKg) {
              if (weight >= AppValue.weightCeilInKgValue &&
                  weight <= AppValue.weightFloorInKgvalue) {
                errorTextForTextField = null;
                isAbleToGoToNextQuestion = true;
                break;
              }
            } else {
              if (weight >= AppValue.weightCeilInLbsValue &&
                  weight <= AppValue.weightFloorInLbsValue) {
                errorTextForTextField = null;
                isAbleToGoToNextQuestion = true;
                break;
              }
            }
          }
          errorTextForTextField = '$text không phù hợp';
          isAbleToGoToNextQuestion = false;
          break;
        case PropertyLink.userGoalWeight:
          double? weight = double.tryParse(text);
          bool isKg = toggleValueForMeasureLayout == 0 ? true : false;
          if (weight != null) {
            if (isKg) {
              if (weight >= AppValue.weightCeilInKgValue &&
                  weight <= AppValue.weightFloorInKgvalue) {
                errorTextForTextField = null;
                isAbleToGoToNextQuestion = true;
                break;
              }
            } else {
              if (weight >= AppValue.weightCeilInLbsValue &&
                  weight <= AppValue.weightFloorInLbsValue) {
                errorTextForTextField = null;
                isAbleToGoToNextQuestion = true;
                break;
              }
            }
          }
          errorTextForTextField = '$text không phù hợp';
          isAbleToGoToNextQuestion = false;
          break;

        default:
          isAbleToGoToNextQuestion = true;
      }
    }
  }

  void validateInputForDateTimeLayout() {
    String text = textFieldControllerForDatePickerLayout.text;
    if (text.isEmpty) {
      isAbleToGoToNextQuestion = false;
      errorTextForTextField = "Ngày sinh không được để trống";
    } else {
      DateFormat df = DateFormat('dd/MM/yyyy');
      try {
        DateTime? date = df.parse(text);
        int yearDiff = DateTime.now().year - date.year;
        if (yearDiff < 16 || yearDiff > 40) {
          isAbleToGoToNextQuestion = false;
          errorTextForTextField = "Tuổi phải từ 16 tới 40";
        } else {
          isAbleToGoToNextQuestion = true;
          errorTextForTextField = null;
        }
      } on FormatException catch (_) {
        isAbleToGoToNextQuestion = false;
        errorTextForTextField = "Tuổi phải từ 16 tới 40";
      }
    }
  }

  @override
  void onInit() {
    super.onInit();

    progressList = List.generate(_moduleMap.length, (index) => 0);
    _updateProgressList();

    textFieldControllerForTextFieldLayout.addListener(() {
      if (textFieldControllerForTextFieldLayout.text.isEmpty) {
        isAbleToGoToNextQuestion = false;
      } else {
        isAbleToGoToNextQuestion = true;
      }
      update();
    });

    textFieldControllerForDatePickerLayout.addListener(() {
      validateInputForDateTimeLayout();
      update();
    });

    textFieldControllerForMeasureLayout.addListener(() {
      validateInputForMeasureLayout();
      update();
    });
  }

  void _passValueForMeasurementLayout(int? toggleValue, String textValue) {
    textFieldControllerForMeasureLayout.text = textValue;
    toggleValueForMeasureLayout = toggleValue;
  }

  void _passValueForDatePickerLayout(String dateTime) {
    textFieldControllerForDatePickerLayout.text = formatDateTime(
        DateFormat(AppString.defaultDateTimeFormat).parse(dateTime));
  }

  void _passValueForTextFieldLayout(String text) {
    textFieldControllerForTextFieldLayout.text = text;
  }

  void _clearValueForMeasurementLayout() {
    textFieldControllerForMeasureLayout.clear();
    toggleValueForMeasureLayout = 0;
    errorTextForTextField = null;
  }

  void _clearValueForDatePickerLayout() {
    textFieldControllerForDatePickerLayout.clear();
    errorTextForTextField = null;
  }

  void _clearValueForTextFieldLayout() {
    textFieldControllerForTextFieldLayout.clear();
  }

  void _passValueForSingleChoiceLayout(dynamic value) {
    if (value == null) return;
    selectedValueForSingleChoiceLayout = value;
    groupValue = getCurrentAnswer()
        .firstWhere((element) => element.enumValue == value)
        .title;
  }

  void _clearValueForSingleChoiceLayout() {
    selectedValueForSingleChoiceLayout = null;
    groupValue = '';
  }

  void _passValueForMultipleChoiceLayout(List<dynamic> listValue) {
    listSelectedValueForMultipleChoiceLayout = listValue;
  }

  void _clearValueForMultipleChoiceLayout() {
    listSelectedValueForMultipleChoiceLayout = <dynamic>[];
    for (var item in getCurrentAnswer()) {
      if (item.isSelected) item.isSelected = false;
    }
  }

  void handleMultipleSelectAnswer(String title) {
    var selectedAnswer = _data.values
        .elementAt(index)
        .firstWhere((element) => element.title == title);

    selectedAnswer.isSelected = !selectedAnswer.isSelected;

    if (!listSelectedValueForMultipleChoiceLayout
        .contains(selectedAnswer.enumValue)) {
      listSelectedValueForMultipleChoiceLayout.add(selectedAnswer.enumValue);
      isAbleToGoToNextQuestion = true;
    } else {
      listSelectedValueForMultipleChoiceLayout.remove(selectedAnswer.enumValue);
      if (listSelectedValueForMultipleChoiceLayout.isEmpty) {
        isAbleToGoToNextQuestion = false;
      }
    }

    update();
  }

  void handleSingleSelectAnswer(String value) {
    var selectedAnswer = _data.values
        .elementAt(index)
        .firstWhere((element) => element.title == value);
    if (groupValue == value) {
      groupValue = '';
      selectedValueForSingleChoiceLayout = null;
    } else {
      groupValue = value;
      selectedValueForSingleChoiceLayout = selectedAnswer.enumValue;
    }
    selectedAnswer.isSelected = !selectedAnswer.isSelected;

    update();
  }

  String formatDateTime(
    DateTime inputDateTime,
  ) {
    return DateFormat(AppString.vnDatetimeFormat).format(inputDateTime);
  }

  void handleSelectDateTime(DateTime inputDateTime) {
    textFieldControllerForDatePickerLayout.text = formatDateTime(inputDateTime);
    update();
  }

  void handleOnUnitChange(int? value) {
    toggleValueForMeasureLayout = value;

    bool isHeightQuesType =
        getCurrentQuestion().propertyLink == PropertyLink.userHeight
            ? true
            : false;
    convertDataBaseOnUnit(
        textFieldControllerForMeasureLayout.text, value, isHeightQuesType);

    validateInputForMeasureLayout();

    update();
  }

  void convertDataBaseOnUnit(
      String textData, int? unitToggleValue, bool isHeightType) {
    if (textData.isEmpty || unitToggleValue == null) return;

    double? data = double.tryParse(textData);
    if (data == null) return;

    if (isHeightType) {
      bool fromCmToFt = unitToggleValue == 1;
      if (fromCmToFt) {
        data = Converter.convertCmToFt(data);
        textFieldControllerForMeasureLayout.text =
            data.toPrecision(2).toString();
      } else {
        data = Converter.convertFtToCm(data);
        textFieldControllerForMeasureLayout.text = data.toStringAsFixed(0);
      }
    } else {
      bool fromKgToLbs = unitToggleValue == 1;
      if (fromKgToLbs) {
        data = Converter.convertKgToLbs(data);
        textFieldControllerForMeasureLayout.text =
            data.toPrecision(2).toString();
      } else {
        data = Converter.convertLbsToKg(data);
        textFieldControllerForMeasureLayout.text = data.toStringAsFixed(0);
      }
    }
  }

  bool isAbleToGoNextQuestion() {
    return isAbleToGoToNextQuestion;
  }

  void _setValueForUserProperty() {
    String propertyToGet = getCurrentQuestion().propertyLink;

    switch (propertyToGet) {
      case PropertyLink.userName:
        name = textFieldControllerForTextFieldLayout.text;
        break;

      case PropertyLink.userWeight:
        weightUnit =
            toggleValueForMeasureLayout == 0 ? WeightUnit.kg : WeightUnit.lbs;
        currentWeight = num.parse(textFieldControllerForMeasureLayout.text);
        break;

      case PropertyLink.userBadHabit:
        List<BadHabit> list = [];
        for (var item in listSelectedValueForMultipleChoiceLayout) {
          if (item != null) {
            list.add(item as BadHabit);
          }
        }
        badHabits = list;
        break;

      case PropertyLink.userDailyWater:
        dailyWater = selectedValueForSingleChoiceLayout as DailyWater;
        break;

      case PropertyLink.userDateOfBirth:
        dateOfBirth = DateFormat(AppString.vnDatetimeFormat)
            .parse(textFieldControllerForDatePickerLayout.text);
        break;

      case PropertyLink.userDiet:
        diet = selectedValueForSingleChoiceLayout as Diet;
        break;

      case PropertyLink.userGender:
        gender = selectedValueForSingleChoiceLayout as Gender;
        break;

      case PropertyLink.userGoalWeight:
        weightUnit =
            toggleValueForMeasureLayout == 0 ? WeightUnit.kg : WeightUnit.lbs;
        goalWeight = num.parse(textFieldControllerForMeasureLayout.text);
        break;

      case PropertyLink.userHeight:
        heightUnit =
            toggleValueForMeasureLayout == 0 ? HeightUnit.cm : HeightUnit.ft;
        currentHeight = num.parse(textFieldControllerForMeasureLayout.text);
        break;

      case PropertyLink.userHobby:
        List<Hobby> list = [];
        for (var item in listSelectedValueForMultipleChoiceLayout) {
          if (item != null) {
            list.add(item as Hobby);
          }
        }
        hobbies = list;
        break;

      case PropertyLink.userLimit:
        List<PhyscialLimitaion> list = [];
        for (var item in listSelectedValueForMultipleChoiceLayout) {
          if (item != null) {
            list.add(item as PhyscialLimitaion);
          }
        }
        limits = list;
        break;

      case PropertyLink.userProteinSource:
        List<ProteinSource> list = [];
        for (var item in listSelectedValueForMultipleChoiceLayout) {
          if (item != null) {
            list.add(item as ProteinSource);
          }
        }
        proteinSources = list;
        break;

      case PropertyLink.userSleepTime:
        sleepTime = selectedValueForSingleChoiceLayout as SleepTime;
        break;

      case PropertyLink.userMainGoal:
        mainGoal = selectedValueForSingleChoiceLayout as MainGoal;
        break;

      case PropertyLink.userBodyType:
        bodyType = selectedValueForSingleChoiceLayout as BodyType;
        break;

      case PropertyLink.userExp:
        experience = selectedValueForSingleChoiceLayout as Experience;
        break;

      case PropertyLink.userTypicalDay:
        typicalDay = selectedValueForSingleChoiceLayout as TypicalDay;
        break;

      case PropertyLink.userActiveFrequency:
        activeFrequency = selectedValueForSingleChoiceLayout as ActiveFrequency;
        break;
      default:
    }

    _clearValueOfFixedControlBaseOnLayoutType(getCurrentQuestion().layoutType);
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
        _passValueForMultipleChoiceLayout(data);
        break;
      case QuestionLayoutType.multipleChoiceTwoColumns:
        _passValueForMultipleChoiceLayout(data);

        break;
      case QuestionLayoutType.singleChoiceOneColumn:
        _passValueForSingleChoiceLayout(data[0]);

        break;
      case QuestionLayoutType.singleChoiceTwoColumns:
        _passValueForSingleChoiceLayout(data[0]);

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
        _clearValueForMultipleChoiceLayout();
        break;
      case QuestionLayoutType.multipleChoiceTwoColumns:
        _clearValueForMultipleChoiceLayout();

        break;
      case QuestionLayoutType.singleChoiceOneColumn:
        _clearValueForSingleChoiceLayout();
        break;
      case QuestionLayoutType.singleChoiceTwoColumns:
        _clearValueForSingleChoiceLayout();
        break;
      case QuestionLayoutType.textField:
        _clearValueForTextFieldLayout();
        break;
      default:
    }
  }

  void _setupValueForNextFixedControl() {
    QuestionLayoutType type = getCurrentQuestion().layoutType;
    String propertyToGet = getCurrentQuestion().propertyLink;

    switch (propertyToGet) {
      case PropertyLink.userName:
        _passValueForFixedControlBaseOnLayoutType(type, [name]);
        break;

      case PropertyLink.userWeight:
        if (weightUnit != null && currentWeight != null) {
          int? toggle = weightUnit == WeightUnit.kg ? 0 : 1;
          String text = currentWeight.toString();
          _passValueForFixedControlBaseOnLayoutType(type, [toggle, text]);
        }

        primaryUnitSymbol = AppString.primaryWeightUnitSymbol;
        secondaryUnitSymbol = AppString.secondaryWeightUnitSymbol;

        break;

      case PropertyLink.userBadHabit:
        _passValueForFixedControlBaseOnLayoutType(type, badHabits ?? []);
        break;

      case PropertyLink.userDailyWater:
        _passValueForFixedControlBaseOnLayoutType(type, [dailyWater]);
        break;

      case PropertyLink.userDateOfBirth:
        if (dateOfBirth != null) {
          _passValueForFixedControlBaseOnLayoutType(
              type, [dateOfBirth.toString()]);
        }
        break;

      case PropertyLink.userDiet:
        _passValueForFixedControlBaseOnLayoutType(type, [diet]);

        break;

      case PropertyLink.userGender:
        _passValueForFixedControlBaseOnLayoutType(type, [gender]);
        break;

      case PropertyLink.userGoalWeight:
        if (goalWeight != null) {
          int? toggle = weightUnit == WeightUnit.kg ? 0 : 1;
          _passValueForFixedControlBaseOnLayoutType(
              type, [toggle, goalWeight.toString(), 'weight']);
        }

        primaryUnitSymbol = AppString.primaryWeightUnitSymbol;
        secondaryUnitSymbol = AppString.secondaryWeightUnitSymbol;

        break;

      case PropertyLink.userHeight:
        if (heightUnit != null && currentHeight != null) {
          int? toggle = heightUnit == HeightUnit.cm ? 0 : 1;
          String text = currentHeight.toString();
          _passValueForFixedControlBaseOnLayoutType(type, [toggle, text]);
        }

        primaryUnitSymbol = AppString.primaryHeightUnitSymbol;
        secondaryUnitSymbol = AppString.secondaryHeightUnitSymbol;

        break;

      case PropertyLink.userHobby:
        _passValueForFixedControlBaseOnLayoutType(type, hobbies ?? []);
        break;

      case PropertyLink.userLimit:
        _passValueForFixedControlBaseOnLayoutType(type, limits ?? []);
        break;

      case PropertyLink.userProteinSource:
        _passValueForFixedControlBaseOnLayoutType(type, proteinSources ?? []);
        break;

      case PropertyLink.userSleepTime:
        _passValueForFixedControlBaseOnLayoutType(type, [sleepTime]);
        break;

      case PropertyLink.userMainGoal:
        _passValueForFixedControlBaseOnLayoutType(type, [mainGoal]);
        break;

      case PropertyLink.userBodyType:
        _passValueForFixedControlBaseOnLayoutType(type, [bodyType]);
        break;

      case PropertyLink.userExp:
        _passValueForFixedControlBaseOnLayoutType(type, [experience]);
        break;

      case PropertyLink.userTypicalDay:
        _passValueForFixedControlBaseOnLayoutType(type, [typicalDay]);
        break;

      case PropertyLink.userActiveFrequency:
        _passValueForFixedControlBaseOnLayoutType(type, [activeFrequency]);
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
    _setValueForUserProperty();
    if (index < _data.length - 1) {
      index++;
      _setupValueForNextFixedControl();
      _updateProgressList();
    } else {
      _finishSetupBasicInformation();
    }
    update();
  }

  void goToPreviousQuestion() {
    _clearValueOfFixedControlBaseOnLayoutType(getCurrentQuestion().layoutType);

    if (index > 0) {
      index--;
      _setupValueForNextFixedControl();
    }
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
      goalWeight: goalWeight as num,
      weightUnit: weightUnit as WeightUnit,
      heightUnit: heightUnit as HeightUnit,
      hobbies: hobbies,
      diet: diet,
      badHabits: badHabits,
      proteinSources: proteinSources,
      limits: limits,
      sleepTime: sleepTime,
      dailyWater: dailyWater,
      mainGoal: mainGoal,
      bodyType: bodyType,
      experience: experience,
      typicalDay: typicalDay,
      activeFrequency: activeFrequency as ActiveFrequency,
      collectionSetting: CollectionSetting(),
    );

    final user = await DataService.instance.createUser(newUser);
    if (user != null) {
      await createWorkoutPlan(user);
      await logWeightTrack(user.currentWeight);
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.error);
    }
  }

  Future<void> logWeightTrack(num currentWeight) async {
    await WeightTrackerProvider().add(
        WeightTracker(date: DateTime.now(), weight: currentWeight.toInt()));
  }

  Future<void> createWorkoutPlan(ViPTUser user) async {
    await DataService.instance.loadWorkoutList();
    await DataService.instance.loadMealList();
    await DataService.instance.loadMealCategoryList();

    await ExerciseNutritionRouteProvider().createRoute(user);
  }

  void skipQuestion() {
    String propertyToGet = getCurrentQuestion().propertyLink;
    _clearValueOfFixedControlBaseOnLayoutType(getCurrentQuestion().layoutType);
    switch (propertyToGet) {
      case PropertyLink.userLimit:
        limits = [PhyscialLimitaion.none];
        break;
      case PropertyLink.userHobby:
        hobbies = [Hobby.none];
        break;
      case PropertyLink.userBadHabit:
        badHabits = [BadHabit.none];
        break;
      case PropertyLink.userProteinSource:
        proteinSources = [ProteinSource.none];
        break;
      default:
    }

    if (index < _data.length - 1) {
      index++;
      _setupValueForNextFixedControl();
      _updateProgressList();
    }

    update();
  }
}
