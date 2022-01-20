import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/routes/pages.dart';
import 'package:vipt/app/data/models/question.dart';

class SetupInfoController extends GetxController {
  late Map<Question, List<Answer>> _data;
  late Map<int, int> _moduleMap;
  late List<double> progressList;
  late int index;

  late User newUser;

  @override
  void onInit() {
    super.onInit();
    _data = AppQuiz.questions;
    _moduleMap = AppQuiz.moduleMap;
    index = 0;
    progressList = List.generate(_moduleMap.length, (index) => 0);
    _updateProgressList();
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
    update();
  }

  void goToPreviousQuestion() {
    if (index > 0) {
      index--;
    }
    _updateProgressList(action: 'back');
    update();
  }

  void finishSetupBasicInformation() {
    // create user voi thong tin cung cap tu quiz

    Get.offAllNamed(Routes.home);
  }
}
