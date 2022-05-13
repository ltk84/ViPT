import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/range_picker_dialog.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_line_chart.dart';

class WeightTrackingWidget extends StatelessWidget {
  final bool showTitle;
  WeightTrackingWidget({
    Key? key,
    this.showTitle = true,
  }) : super(key: key);

  // DateFormat chỉnh trong file statistic_line_chart.dart, hàm getFlSpot
  final Map<String, double> values = {
    '2022/05/14': 79.2,
    '2022/07/12': 81,
    '2022/08/10': 79.3,
    '2022/03/15': 79.5,
    '2022/01/16': 82,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showTitle)
          Row(
            children: [
              Text(
                'Theo dõi cân nặng',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: AppColor.textColor
                          .withOpacity(AppColor.subTextOpacity),
                    ),
              ),
            ],
          ),
        if (showTitle)
          const SizedBox(
            height: 24,
          ),
        StatisticLineChart(
          values: values,
          title: "Tuần 09/05/22 - 15/05/22",
          description: "Cân nặng (kg)",
          onPressHandler: () async {
            final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const RangePickerDialog();
              },
            );
            print(result);
          },
        ),
      ],
    );
  }
}
