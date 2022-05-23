import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/core/values/app_strings.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/plan_exercise.dart';
import 'package:vipt/app/data/models/plan_exercise_collection.dart';
import 'package:vipt/app/data/models/plan_exercise_collection_setting.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_plan.dart';
import 'package:vipt/app/data/providers/plan_exercise_collection_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_collection_setting_provider.dart';
import 'package:vipt/app/data/providers/plan_exercise_provider.dart';
import 'package:vipt/app/data/providers/workout_plan_meal_provider.dart';
import 'package:vipt/app/data/providers/workout_plan_provider.dart';
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
      if (textFieldControllerForDatePickerLayout.text.isEmpty) {
        isAbleToGoToNextQuestion = false;
      } else {
        isAbleToGoToNextQuestion = true;
      }
      update();
    });

    textFieldControllerForMeasureLayout.addListener(() {
      if (textFieldControllerForMeasureLayout.text.isEmpty) {
        isAbleToGoToNextQuestion = false;
      } else {
        isAbleToGoToNextQuestion = true;
      }
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
  }

  void _clearValueForDatePickerLayout() {
    textFieldControllerForDatePickerLayout.clear();
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
    update();
  }

  // num _convertKgToLbs(num value) => value * 2.2;
  // num _convertLbsToKg(num value) => value / 2.2;
  // num _convertCmToFt(num value) => value / 30.48;
  // num _convertFtToCm(num value) => value * 30.48;

  // void weightUnitSetter(int? toggleValue) {
  //   WeightUnit result = toggleValue == 0 ? WeightUnit.kg : WeightUnit.lbs;
  //   if (weightUnit != null && weightUnit != result) {
  //     if (currentWeight != null) {
  //       currentWeight = result == WeightUnit.kg
  //           ? _convertLbsToKg(currentWeight as num)
  //           : _convertKgToLbs(currentWeight as num);
  //     }
  //     if (goalWeight != null) {
  //       goalWeight = result == WeightUnit.kg
  //           ? _convertLbsToKg(goalWeight as num)
  //           : _convertKgToLbs(goalWeight as num);
  //     }
  //   }
  // }

  // void heightUnitSetter(int? toggleValue) {
  //   HeightUnit result = toggleValue == 0 ? HeightUnit.cm : HeightUnit.ft;
  //   if (heightUnit != null && heightUnit != result) {
  //     if (currentHeight != null) {
  //       currentHeight = result == HeightUnit.cm
  //           ? _convertCmToFt(currentHeight as num)
  //           : _convertFtToCm(currentHeight as num);
  //     }
  //   }
  // }

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
      diet: diet as Diet,
      badHabits: badHabits,
      proteinSources: proteinSources,
      limits: limits,
      sleepTime: sleepTime as SleepTime,
      dailyWater: dailyWater as DailyWater,
      mainGoal: mainGoal as MainGoal,
      bodyType: bodyType as BodyType,
      experience: experience as Experience,
      typicalDay: typicalDay as TypicalDay,
      activeFrequency: activeFrequency as ActiveFrequency,
      collectionSetting: CollectionSetting(),
    );

    final user = await DataService.instance.createUser(newUser);
    if (user != null) {
      await createWorkoutPlan(user);
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.error);
    }
    // await createWorkoutPlan(newUser);
  }

  // tính toán endDate, meal list, exercise list
  Future<void> createWorkoutPlan(ViPTUser user) async {
    final _workoutPlanProvider = WorkoutPlanProvider();
    // final _wkMealProvider = WorkoutPlanMealProvider();
    // final _wkExerciseProvider = PlanExerciseCollectionProvider();

    await DataService.instance.loadWorkoutList();

    num weightDiff = user.goalWeight - user.currentWeight;
    num workoutPlanLengthInWeek =
        weightDiff.abs() / AppValue.intensityWeightPerWeek;
    int workoutPlanLengthInDays = workoutPlanLengthInWeek.toInt() * 7;

    DateTime workoutPlanStartDate = DateTime.now();
    DateTime workoutPlanEndDate =
        DateTime.now().add(Duration(days: workoutPlanLengthInDays));

    num dailyGoalCalories = WorkoutPlanUtils.createDailyGoalCalories(user);
    num intakeCalories = dailyGoalCalories + AppValue.intensityWeight;
    num outtakeCalories = AppValue.intensityWeight;

    final WorkoutPlan workoutPlan = WorkoutPlan(
        dailyGoalCalories: dailyGoalCalories,
        startDate: workoutPlanStartDate,
        endDate: workoutPlanEndDate);
    _workoutPlanProvider.add(workoutPlan);

    generateMealList(intakeCalories);
    generateExerciseListWithPlanLength(
        outtakeCalories, user.currentWeight, workoutPlanLengthInDays);
  }

  void generateExerciseListWithPlanLength(
      num outtakeCalories, num userWeight, int workoutPlanLength) {
    // for (int i = 0; i < workoutPlanLength; i++) {
    //   generateExerciseListEveryDay(outtakeCalories, userWeight);
    // }
    generateExerciseListEveryDay(
        outtakeCalories: outtakeCalories,
        userWeight: userWeight,
        date: DateTime.now());
  }

  Future<void> generateExerciseListEveryDay(
      {required num outtakeCalories,
      required num userWeight,
      required DateTime date}) async {
    int numberOfExercise = 10;
    int everyExerciseSeconds = 45;
    List<Workout> exerciseList1 = randomExercises(numberOfExercise);
    List<Workout> exerciseList2 = randomExercises(numberOfExercise);

    double totalCalo1 = 0;
    for (var element in exerciseList1) {
      double calo = SessionUtils.calculateCaloOneWorkout(
          everyExerciseSeconds, element.metValue, userWeight);
      totalCalo1 += calo;
    }

    double totalCalo2 = 0;
    for (var element in exerciseList2) {
      double calo = SessionUtils.calculateCaloOneWorkout(
          everyExerciseSeconds, element.metValue, userWeight);
      totalCalo2 += calo;
    }

    int round1 = ((outtakeCalories / 2) / totalCalo1).ceil();
    int round2 = ((outtakeCalories / 2) / totalCalo2).ceil();

    //  tao collection setting
    PlanExerciseCollectionSetting setting1 = PlanExerciseCollectionSetting(
        round: round1,
        exerciseTime: everyExerciseSeconds,
        numOfWorkoutPerRound: numberOfExercise);

    PlanExerciseCollectionSetting setting2 = PlanExerciseCollectionSetting(
        round: round2,
        exerciseTime: everyExerciseSeconds,
        numOfWorkoutPerRound: numberOfExercise);

    final _settingProvider = PlanExerciseCollectionSettingProvider();
    setting1 = (await _settingProvider.add(setting1))!;
    setting2 = (await _settingProvider.add(setting2))!;

    PlanExerciseCollection collection1 = PlanExerciseCollection(
        date: date, collectionSettingID: setting1.id ?? 0);

    PlanExerciseCollection collection2 = PlanExerciseCollection(
        date: date, collectionSettingID: setting2.id ?? 0);

    final _collectionProvider = PlanExerciseCollectionProvider();
    collection1 = (await _collectionProvider.add(collection1))!;
    collection2 = (await _collectionProvider.add(collection2))!;

    final _exerciseProvider = PlanExerciseProvider();
    for (var element in exerciseList1) {
      PlanExercise pe = PlanExercise(
          exerciseID: element.id ?? '', listID: collection1.id ?? 0);
      _exerciseProvider.add(pe);
    }

    for (var element in exerciseList2) {
      PlanExercise pe = PlanExercise(
          exerciseID: element.id ?? '', listID: collection2.id ?? 0);
      _exerciseProvider.add(pe);
    }
  }

  List<Workout> randomExercises(int numberOfExercise) {
    int count = 0;
    final _random = Random();
    List<Workout> result = [];
    final allExerciseList = DataService.instance.workoutList;
    while (count < numberOfExercise) {
      var element = allExerciseList[_random.nextInt(allExerciseList.length)];
      if (!result.contains(element)) {
        result.add(element);
        count++;
      }
    }

    return result;
  }

  void generateMealList(num intakeCalories) {}

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
