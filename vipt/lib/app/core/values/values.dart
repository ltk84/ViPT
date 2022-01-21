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
    0: 2,
    1: 2,
    2: 3,
    3: 2,
  };

  static const Map<Question, List<Answer>> questions = {
    Question(
        title: 'Question A',
        description: '',
        moduleParent: 0,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.measurementPicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question B',
        description: '',
        moduleParent: 0,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question C',
        description: '',
        moduleParent: 1,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.measurementPicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question D',
        description: '',
        moduleParent: 1,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question E',
        description: '',
        moduleParent: 2,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question F',
        description: '',
        moduleParent: 2,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question G',
        description: '',
        moduleParent: 2,
        moduleIndex: 3,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question H',
        description: '',
        moduleParent: 3,
        moduleIndex: 1,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    Question(
        title: 'Question I',
        description: '',
        moduleParent: 3,
        moduleIndex: 2,
        layoutType: QuestionLayoutType.datePicker): [
      Answer(title: 'vcl', description: '', asset: null)
    ],
    // Question(
    //     title: 'Question K',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
    // Question(
    //     title: 'Question L',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
    // Question(
    //     title: 'Question M',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
    // Question(
    //     title: 'Question N',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
    // Question(
    //     title: 'Question O',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
    // Question(
    //     title: 'Question P',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
    // Question(
    //     title: 'Question Q',
    //     description: '',
    //     layoutType: QuestionLayoutType.datePicker): [
    //   Answer(title: 'vcl', description: '', asset: null)
    // ],
  };
}

class AppValue {
  static const userCollectionPath = 'user';
}
