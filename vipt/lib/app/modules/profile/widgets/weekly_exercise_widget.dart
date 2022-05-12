import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_bar_chart.dart';
import 'package:vipt/app/modules/profile/widgets/week_picker_dialog.dart';

class WeeklyExerciseWidget extends StatelessWidget {
  WeeklyExerciseWidget({Key? key}) : super(key: key);
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
            _buildExtraInfo(context, title: 'phút luyện tập', value: '50'),
            _buildExtraInfo(context, title: 'calories tiêu hao', value: '200'),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        StatisticBarChart(
          values: values,
          title: "Tuần 09/05/22 - 15/05/22",
          description: "Lượng calories tiêu hao (kcal)",
          onPressHandler: () async {
            DatePeriod? result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const WeekPickerDialog();
              },
            );
            if (result != null) {
              print(result.start);
              print(result.end);
            }
          },
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
