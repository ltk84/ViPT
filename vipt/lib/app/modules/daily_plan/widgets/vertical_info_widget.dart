import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class VerticalInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool reverse;

  const VerticalInfoWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildContent(context);
  }

  Widget buildContent(BuildContext context) {
    return reverse
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                subtitle,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: AppColor.accentTextColor,
                    ),
              ),
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
