import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/range_picker_dialog.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_line_chart.dart';

class WeightTrackingWidget extends StatelessWidget {
  final bool showTitle;
  final DateTimeRange timeRange;
  final Map<DateTime, double> weighTracks;
  final Function(DateTime, DateTime) handleChangeTimeRange;
  const WeightTrackingWidget({
    Key? key,
    this.showTitle = true,
    required this.timeRange,
    required this.weighTracks,
    required this.handleChangeTimeRange,
  }) : super(key: key);

  String formatDateTime(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    String startDateStr = formatDateTime(timeRange.start);
    String endDateStr = formatDateTime(timeRange.end);

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
          dateRange: timeRange,
          values: weighTracks,
          title: "Từ $startDateStr - $endDateStr",
          description: "Cân nặng (kg)",
          onPressHandler: () async {
            final DatePeriod? result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return RangePickerDialog(
                  selectedPeriod: DatePeriod(timeRange.start, timeRange.end),
                );
              },
            );
            if (result != null) {
              handleChangeTimeRange(result.start, result.end);
            }
          },
        ),
      ],
    );
  }
}
