import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_bar_chart.dart';

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
            _buildExtraInfo(context, title: 'calories hấp thụ', value: '200'),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        StatisticBarChart(
          values: values,
          title: "Tuần 09/05/22 - 15/05/22",
          description: "Lượng calories hấp thụ (kcal)",
          titleColor: AppColor.statisticNutritionTitleColor,
          descriptionColor: AppColor.statisticNutritionDescriptionColor,
          backgroundColor: AppColor.statisticNutritionBackgroundColor,
          emptyBarColor: AppColor.statisticNutritionBarColor,
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
