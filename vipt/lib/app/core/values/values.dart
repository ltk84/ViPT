import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/data/models/question.dart';
import 'package:vipt/app/enums/app_enums.dart';

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
    const Question(
        canBeSkipped: true,
        title: 'Tên của bạn là gì?',
        description: '',
        moduleParent: 0,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.textField): [],
    const Question(
        title: 'Mục tiêu về cân nặng',
        description: 'Bạn muốn mình có thể đạt được mức cân nặng bao nhiêu?',
        moduleParent: 0,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.measurementPicker): [],
    const Question(
        title: 'Giới tính',
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.',
        moduleParent: 0,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'Nam', description: '', asset: null),
      Answer(title: 'Nữ', description: '', asset: null),
      Answer(title: 'Khác', description: '', asset: null),
    ],
    const Question(
        title: 'Ngày sinh',
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.',
        moduleParent: 0,
        moduleIndex: 4,
        layoutType: QuestionLayoutType.datePicker): [],
    const Question(
        title: 'Cân nặng hiện tại',
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.',
        moduleParent: 0,
        moduleIndex: 5,
        layoutType: QuestionLayoutType.measurementPicker): [],
    const Question(
        title: 'Chiều cao hiện tại',
        description:
            'Việc thu thập thông tin này sẽ giúp tôi có thể tính toán BMI và tạo ra một kế hoạch cân nặng lành mạnh cá nhân cho riêng bạn.',
        moduleParent: 0,
        moduleIndex: 6,
        layoutType: QuestionLayoutType.measurementPicker): [],
    const Question(
        title: 'Mục tiêu chính',
        description:
            'Bạn hãy chọn một lựa chọn phù hợp nhất trong những lựa chọn bên dưới.',
        moduleParent: 0,
        moduleIndex: 7,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    const Question(
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
    const Question(
        title: 'Kiểu cơ thể',
        description: 'Hình ảnh nào dưới đây gần giống với bạn nhất?',
        moduleParent: 0,
        moduleIndex: 9,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    const Question(
        title: 'Sở thích',
        description: '',
        moduleParent: 0,
        moduleIndex: 10,
        layoutType: QuestionLayoutType.multipleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    const Question(
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
    const Question(
        title: 'Kiểu ngày bình thường của bạn?',
        description:
            'Để có thể đạt được mục tiêu về vóc dáng cơ thể thì mỗi cá nhân đều có một hướng tiếp cận riêng dựa trên thói quen của chính mình.',
        moduleParent: 1,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.singleChoiceOneColumn): [
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
      Answer(title: 'vcl', description: '', asset: null),
    ],
    const Question(
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
    const Question(
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
    const Question(
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
    const Question(
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
    const Question(
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
    const Question(
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
