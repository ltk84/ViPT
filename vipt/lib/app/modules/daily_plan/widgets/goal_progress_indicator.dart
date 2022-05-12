import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vipt/app/core/values/colors.dart';

class GoalProgressIndicator extends StatelessWidget {
  final int value;
  final String unitString;
  final double radius;
  final int? goalValue;
  const GoalProgressIndicator(
      {Key? key,
      required this.value,
      required this.unitString,
      this.radius = 134,
      this.goalValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progress = goalValue == null ? 1 : value / goalValue!;

    return CircularPercentIndicator(
      percent: progress > 1 ? 1 : progress,
      radius: radius,
      lineWidth: 6,
      backgroundColor:
          AppColor.accentTextColor.withOpacity(AppColor.subTextOpacity),
      progressColor: AppColor.accentTextColor,
      center: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: '$value',
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppColor.accentTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  if (goalValue != null) TextSpan(text: '/$goalValue'),
                ],
              ),
            ),
            Text(
              unitString,
              style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColor.accentTextColor,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
