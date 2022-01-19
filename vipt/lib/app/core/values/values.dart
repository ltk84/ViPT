import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vipt/app/data/models/answer.dart';

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
  static const Map<String, Answer?> questions = {
    'Question A': Answer(title: 'vcl', description: '', asset: null),
    'Question B': Answer(title: 'vcl', description: '', asset: null),
    'Question C': Answer(title: 'vcl', description: '', asset: null),
    'Question D': Answer(title: 'vcl', description: '', asset: null),
    'Question E': Answer(title: 'vcl', description: '', asset: null),
    'Question F': Answer(title: 'vcl', description: '', asset: null),
    'Question G': Answer(title: 'vcl', description: '', asset: null),
    'Question H': Answer(title: 'vcl', description: '', asset: null),
    'Question I': Answer(title: 'vcl', description: '', asset: null),
    'Question K': Answer(title: 'vcl', description: '', asset: null),
    'Question L': Answer(title: 'vcl', description: '', asset: null),
    'Question M': Answer(title: 'vcl', description: '', asset: null),
    'Question N': Answer(title: 'vcl', description: '', asset: null),
    'Question O': Answer(title: 'vcl', description: '', asset: null),
    'Question P': Answer(title: 'vcl', description: '', asset: null),
    'Question Q': Answer(title: 'vcl', description: '', asset: null),
  };
}

class AppValue {
  static const userCollectionPath = 'user';
}
