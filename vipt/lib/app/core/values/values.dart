import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/question.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import 'colors.dart';

class AppDecoration {
  static const EdgeInsets screenPadding = EdgeInsets.fromLTRB(24, 24, 24, 24);
  static InputDecoration noHighlightInputDecoration = InputDecoration(
    border: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
    enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
    focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColor.textFieldUnderlineColor)),
  );
  static InputDecoration fillInputDecoration = InputDecoration(
    filled: true,
    fillColor: AppColor.textFieldFill,
    border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        )),
  );
  static InputDecoration dateTimeFieldDecoration = InputDecoration(
    filled: true,
    suffixIcon: const Icon(
      Icons.calendar_today_rounded,
      size: 18,
    ),
    fillColor: AppColor.textFieldFill,
    border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(28),
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(10),
        )),
  );
}

class AppQuiz {
  static const Map<int, int> moduleMap = {
    0: 11,
    1: 4,
    2: 4,
  };

  static Map<Question, List<Answer>> questions = {
    // Module 1
    Question(
        title: 'Tên của bạn là gì?'.tr,
        description: '',
        moduleParent: 0,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.textField): [],
    Question(
        title: 'Mục tiêu về cân nặng'.tr,
        description: 'Bạn muốn mình có thể đạt được mức cân nặng bao nhiêu?'.tr,
        moduleParent: 0,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        title: 'Giới tính'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Nam'.tr,
          description: '',
          asset: SVGAssetString.male,
          enumValue: Gender.male),
      Answer(
          title: 'Nữ'.tr,
          description: '',
          asset: SVGAssetString.female,
          enumValue: Gender.female),
      Answer(
          title: 'Khác'.tr,
          description: '',
          asset: SVGAssetString.otherGender,
          enumValue: Gender.other),
    ],
    Question(
        title: 'Ngày sinh'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 4,
        layoutType: QuestionLayoutType.datePicker): [],
    Question(
        title: 'Cân nặng hiện tại'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 5,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        title: 'Chiều cao hiện tại'.tr,
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.'
                .tr,
        moduleParent: 0,
        moduleIndex: 6,
        layoutType: QuestionLayoutType.measurementPicker): [],
    Question(
        title: 'Mục tiêu chính'.tr,
        description:
            'Bạn hãy chọn một lựa chọn phù hợp nhất trong những lựa chọn bên dưới.'
                .tr,
        moduleParent: 0,
        moduleIndex: 7,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(
          title: 'Giảm cân, giảm mỡ'.tr,
          description: '',
          asset: null,
          enumValue: MainGoal.loseWeight),
      Answer(
          title: 'Tăng cơ bắp'.tr,
          description: '',
          asset: null,
          enumValue: MainGoal.buildMuscle),
      Answer(
          title: 'Có vóc dáng đẹp, vừa vặn'.tr,
          description: '',
          asset: null,
          enumValue: MainGoal.getFit),
      Answer(
          title: 'Tăng sức mạnh'.tr,
          description: '',
          asset: null,
          enumValue: MainGoal.gainStrength),
    ],
    Question(
        title: 'Các vấn đề đặc biệt',
        description: '',
        moduleParent: 0,
        moduleIndex: 8,
        layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        title: 'Kiểu cơ thể',
        description: 'Hình ảnh nào dưới đây gần giống với bạn nhất?',
        moduleParent: 0,
        moduleIndex: 9,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        canBeSkipped: true,
        title: 'Sở thích'.tr,
        description: '',
        moduleParent: 0,
        moduleIndex: 10,
        layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
      Answer(title: 'Tập luyện tại nhà', description: '', asset: null),
      Answer(title: 'Đi bộ', description: '', asset: null),
      Answer(title: 'Chạy bộ', description: '', asset: null),
      Answer(title: 'Yoga', description: '', asset: null),
      Answer(title: 'Nhảy', description: '', asset: null),
      Answer(title: 'Gym', description: '', asset: null),
      Answer(title: 'Fighting', description: '', asset: null),
    ],
    Question(
        title: 'Kinh nghiệm',
        description: '',
        moduleParent: 0,
        moduleIndex: 11,
        layoutType: QuestionLayoutType.singleChoiceTwoColumns): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],

    // Module 2
    Question(
        title: 'Kiểu ngày bình thường của bạn?',
        description:
            'Để có thể đạt được mục tiêu về vóc dáng cơ thể thì mỗi cá nhân đều có một hướng tiếp cận riêng dựa trên thói quen của chính mình.',
        moduleParent: 1,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        title: 'Bạn thường vận động như thế nào?',
        description: '',
        moduleParent: 1,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        title: 'Mỗi đêm bạn dành ra bao nhiêu thời gian để ngủ?',
        description:
            'Việc ngủ đủ giấc là rất cần thiết trong việc hình thành nên vóc dáng cơ thể đẹp.',
        moduleParent: 1,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        title: 'Thói quen xấu',
        description: '',
        moduleParent: 1,
        moduleIndex: 4,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],

    // Module 3
    Question(
        title: 'Chế độ ăn kiêng của bạn',
        description: 'Hãy chọn theo thói quen hằng ngày hoặc sở thích của bạn.',
        moduleParent: 2,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        title: 'Nguồn chất đạm',
        description: 'Hãy chọn theo thói quen hằng ngày hoặc sở thích của bạn.',
        moduleParent: 2,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    Question(
        title: 'Một ngày bạn uống bao nhiêu nước?',
        description: '',
        moduleParent: 2,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
  };
}

class AppValue {
  static const userCollectionPath = 'user';
}
