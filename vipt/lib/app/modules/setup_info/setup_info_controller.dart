import 'package:get/get.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/routes/pages.dart';

class SetupInfoController extends GetxController {
  final Map<String, Answer?> data = AppQuiz.questions;
  int index = 0;

  void goToNextQuestion() {
    if (index < data.length - 1) {
      index++;
    }
    update();
  }

  void goToPreviousQuestion() {
    if (index > 0) {
      index--;
    }
    update();
  }

  void finishSetupBasicInformation() {
    // create user voi thong tin cung cap tu quiz

    Get.offAllNamed(Routes.home);
  }
}
