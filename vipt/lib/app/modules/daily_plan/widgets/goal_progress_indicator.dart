import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class GoalProgressIndicator extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progressValue;
  const GoalProgressIndicator(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.progressValue = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  AppColor.accentTextColor.withOpacity(AppColor.subTextOpacity),
              width: 6,
            ),
            shape: BoxShape.circle,
          ),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppColor.accentTextColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          left: 11,
          right: 11,
          top: 3,
          bottom: 3,
          child: CircularProgressIndicator(
            color: AppColor.accentTextColor,
            value: progressValue,
            strokeWidth: 7,
          ),
        ),
      ],
    );
  }
}
