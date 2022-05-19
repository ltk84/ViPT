import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_bar_chart.dart';
import 'package:vipt/app/modules/profile/widgets/week_picker_dialog.dart';

class WeeklyExerciseWidget extends StatelessWidget {
  WeeklyExerciseWidget({
    Key? key,
  }) : super(key: key);

  final _controller = Get.find<ProfileController>();

  final List<int> values = [0, 00, 00, 00, 00, 00, 0, 1];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Luyện tập mỗi tuần',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color:
                        AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                  ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => _buildExtraInfo(context,
                  title: 'phút luyện tập',
                  value: _controller.exerciseMinutesWeekly.toString()),
            ),
            Obx(
              () => _buildExtraInfo(context,
                  title: 'calories tiêu hao',
                  value: _controller.exerciseCaloriesWeekly.toString()),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Obx(
          () => StatisticBarChart(
            values: _controller.exerciseCaloList,
            title:
                "Tuần ${_controller.exerciseStartDateStr.value} - ${_controller.exerciseEndDateStr.value}",
            description: "Lượng calories tiêu hao (kcal)",
            onPressHandler: () async {
              DatePeriod? result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return WeekPickerDialog(
                    selectedDate: _controller.exerciseDateRange.value.start,
                  );
                },
              );
              if (result != null) {
                await _controller.changeExerciseDateRange(
                    result.start, result.end);
              }
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildExtraInfo(context,
    {required String title, required String value}) {
  return Column(
    children: [
      Text(
        value,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(title, style: Theme.of(context).textTheme.bodyText1),
    ],
  );
}
