import 'package:vipt/app/core/values/app_strings.dart';
import 'package:vipt/app/enums/app_enums.dart';

class Question {
  final String title;
  final String description;
  final QuestionLayoutType layoutType;
  final int moduleParent;
  final int moduleIndex;
  final bool canBeSkipped;
  final String propertyLink;

  const Question({
    required this.title,
    required this.description,
    required this.layoutType,
    required this.moduleParent,
    required this.moduleIndex,
    this.propertyLink = PropertyLink.none,
    this.canBeSkipped = false,
  });
}
