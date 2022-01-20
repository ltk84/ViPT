import 'package:vipt/app/enums/app_enums.dart';

class Question {
  final String title;
  final String description;
  final QuestionLayoutType layoutType;
  final int moduleParent;
  final int moduleIndex;

  const Question({
    required this.title,
    required this.description,
    required this.layoutType,
    required this.moduleParent,
    required this.moduleIndex,
  });
}
