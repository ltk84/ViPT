import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class VerticalInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const VerticalInfoWidget(
      {Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppColor.accentTextColor,
              ),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: AppColor.accentTextColor,
              ),
        ),
      ],
    );
  }
}
