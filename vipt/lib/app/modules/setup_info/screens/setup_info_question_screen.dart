import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/answer.dart';
import 'package:vipt/app/enums/app_enums.dart';
import 'package:vipt/app/modules/error/screens/error_screen.dart';
import 'package:vipt/app/modules/setup_info/setup_info_controller.dart';
import 'package:vipt/app/modules/setup_info/widgets/custom_progress_indicator.dart';
import 'package:vipt/app/modules/setup_info/widgets/date_picker_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/measurement_picker_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_one_column_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_two_colums_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/single_choice_one_columns_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/single_choice_two_columns_layout.dart';
import 'package:vipt/app/modules/setup_info/widgets/text_field_layout.dart';

class SetupInfoQuestionScreen extends StatelessWidget {
  SetupInfoQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: null,
        body: Container(
          padding: AppDecoration.screenPadding,
          child: _buildQuestion(context),
        ),
      ),
    );
  }
}

Widget _buildQuestion(context) {
  return GetBuilder<SetupInfoController>(
    init: SetupInfoController(),
    builder: (controller) => Column(
      children: [
        _buildTopPanel(
          context,
          moduleCount: controller.getModuleCount(),
          progress: controller.progressList,
        ),
        const SizedBox(
          height: 20,
        ),
        _buildQuestionTitle(context,
            title: controller.getCurrentQuestion().title,
            description: controller.getCurrentQuestion().description),
        const SizedBox(
          height: 10,
        ),
        _buildQuestionLayout(
            context, controller.getCurrentQuestion().layoutType),
        const SizedBox(
          height: 20,
        ),
        _buildNextQuestionButton(context, controller),
        controller.getCurrentQuestion().canBeSkipped == true
            ? _buildSkipButton(context)
            : Container(
                color: Colors.transparent,
                height: 46,
                width: double.maxFinite,
              ),
      ],
    ),
  );
}

Widget _buildQuestionLayout(context, QuestionLayoutType layoutType) {
  return Expanded(
    child: Container(
      //padding: const EdgeInsets.symmetric(horizontal: 40),
      child: GetBuilder<SetupInfoController>(
          builder: (controller) =>
              _handleLayoutSelection(context, layoutType, controller)),
    ),
  );
}

Widget _handleLayoutSelection(
    context, QuestionLayoutType layoutType, SetupInfoController controller) {
  switch (layoutType) {
    case QuestionLayoutType.datePicker:
      return DatePickerLayout(
        textFieldController: controller.textFieldControllerForDatePickerLayout,
        handleChangeDateTime: controller.handleSelectDateTime,
      );
    case QuestionLayoutType.measurementPicker:
      return MeasurementPickerLayout(
        onUnitChanged: (int? value) {
          controller.handleOnUnitChange(value);
        },
        textFieldControllerForMeasureLayout:
            controller.textFieldControllerForMeasureLayout,
        toggleValueForMeasureLayout: controller.toggleValueForMeasureLayout,
      );
    case QuestionLayoutType.textField:
      return TextFieldLayout(
        textEditingController: controller.textFieldControllerForTextFieldLayout,
      );
    case QuestionLayoutType.multipleChoiceOneColumn:
      return MultipleChoiceOneColumnLayout(
        listAnswers: controller.getCurrentAnswer(),
      );
    case QuestionLayoutType.multipleChoiceTwoColumns:
      return MultipleChoiceTwoColumnsLayout(
        listAnswers: controller.getCurrentAnswer(),
      );
    case QuestionLayoutType.singleChoiceOneColumn:
      return SingleChoiceOneColumnLayout(
        groupValue: controller.groupValue!.value,
        listAnswers: controller.getCurrentAnswer(),
      );
    case QuestionLayoutType.singleChoiceTwoColumns:
      return SingleChoiceTwoColumnsLayout(
        groupValue: controller.groupValue!.value,
        listAnswers: controller.getCurrentAnswer(),
      );
    default:
      return const ErrorScreen();
  }
}

Widget _buildTopPanel(context,
    {required int moduleCount, required List<double> progress}) {
  final _controller = Get.find<SetupInfoController>();
  int currentIndex = _controller.index;

  return Stack(
    alignment: Alignment.centerLeft,
    children: [
      IconButton(
        iconSize: 24,
        onPressed: () {
          currentIndex == 0 ? Get.back() : _controller.goToPreviousQuestion();
        },
        icon: Icon(
          currentIndex == 0 ? Icons.close : Icons.arrow_back_ios,
          color: AppColor.textColor,
        ),
      ),
      CustomProgressIndicator(
        moduleCount: moduleCount,
        progress: progress,
      ),
    ],
  );
}

Widget _buildQuestionTitle(context,
    {required String title, required String description}) {
  return Column(
    children: [
      Text(
        title.tr,
        style: Theme.of(context).textTheme.headline2,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        description.tr,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget _buildNextQuestionButton(
  context,
  SetupInfoController controller,
) {
  return Container(
    color: Colors.transparent,
    width: double.maxFinite,
    height: 46,
    child: ElevatedButton(
      onPressed: !controller.isAbleToGoNextQuestion()
          ? null
          : () {
              controller.goToNextQuestion();
            },
      child: Text('Tiếp theo'.tr, style: Theme.of(context).textTheme.button),
    ),
  );
}

Widget _buildSkipButton(context) {
  return Container(
    color: Colors.transparent,
    height: 46,
    width: double.maxFinite,
    child: TextButton(
      onPressed: () {},
      child: Text(
        'Không có lựa chọn nào ở trên'.tr,
        style: Theme.of(context).textTheme.button!.copyWith(
              fontSize: 16,
              color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
            ),
      ),
    ),
  );
}
