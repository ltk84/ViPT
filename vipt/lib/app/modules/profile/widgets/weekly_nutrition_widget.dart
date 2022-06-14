import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_bar_chart.dart';
import 'package:vipt/app/modules/profile/widgets/week_picker_dialog.dart';

class WeeklyNutritionWidget extends StatelessWidget {
  WeeklyNutritionWidget({Key? key}) : super(key: key);

  final List<int> values = [
    100,
    200,
    300,
    150,
    50,
    0,
    200,
  ];

  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Dinh dưỡng mỗi tuần',
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
            Obx(() => _buildExtraInfo(context,
                title: 'calories hấp thụ',
                value: _controller.nutritionCaloWeekly.value.toString())),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        Obx(
          () => StatisticBarChart(
            values: _controller.nutritionCaloList,
            title:
                "Tuần ${_controller.nutritionStartDateStr.value} - ${_controller.nutritionEndDateStr.value}",
            description: "Lượng calories hấp thụ (kcal)",
            titleColor: AppColor.statisticNutritionTitleColor,
            descriptionColor: AppColor.statisticNutritionDescriptionColor,
            backgroundColor: AppColor.statisticNutritionBackgroundColor,
            emptyBarColor: AppColor.statisticNutritionBarColor,
            onPressHandler: () async {
              DatePeriod? result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return WeekPickerDialog(
                    selectedDate: _controller.nutritionDateRange.value.start,
                  );
                },
              );
              if (result != null) {
                await _controller.changeNutritionDateChange(
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
