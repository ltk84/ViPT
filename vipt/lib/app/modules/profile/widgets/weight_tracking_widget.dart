import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/modules/profile/widgets/range_picker_dialog.dart';
import 'package:vipt/app/modules/profile/widgets/statistic_line_chart.dart';

class WeightTrackingWidget extends StatelessWidget {
  final bool showTitle;
  WeightTrackingWidget({
    Key? key,
    this.showTitle = true,
  }) : super(key: key);

  // DateFormat chỉnh trong file statistic_line_chart.dart, hàm getFlSpot
  final Map<DateTime, double> values = {
    DateTime(2022, 05, 9): -1,
    DateTime(2022, 05, 10): 0,
    // DateTime(2022, 07, 12): 81,
    // DateTime(2022, 08, 10): 79.3,
    // DateTime(2022, 03, 15): 79.5,
    // DateTime(2022, 01, 16): 82,
  };

  final _controller = Get.find<ProfileController>();

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
        Obx(
          () => StatisticLineChart(
            values: _controller.weightTrackList,
            title:
                "Tuần ${_controller.weightStartDateStr} - ${_controller.weightEndDateStr}",
            description: "Cân nặng (kg)",
            onPressHandler: () async {
              final DatePeriod? result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RangePickerDialog(
                    selectedPeriod: DatePeriod(
                        _controller.weightDateRange.value.start,
                        _controller.weightDateRange.value.end),
                  );
                },
              );
              if (result != null) {
                _controller.changeWeighDateRange(result.start, result.end);
              }
            },
          ),
        ),
      ],
    );
  }
}
