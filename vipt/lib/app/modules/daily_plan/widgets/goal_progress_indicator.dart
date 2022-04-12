import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:vipt/app/core/values/colors.dart';

class GoalProgressIndicator extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressValue;
  final double radius;
  const GoalProgressIndicator(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.progressValue = 1,
      this.radius = 134})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      percent: progressValue,
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
            Text(
              title,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: AppColor.accentTextColor,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              subtitle,
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
