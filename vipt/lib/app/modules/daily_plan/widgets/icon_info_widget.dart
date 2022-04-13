import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/colors.dart';

class IconInfoWidget extends StatelessWidget {
  final String title;
  final Widget icon;

  const IconInfoWidget({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        const SizedBox(
          height: 8,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.caption!.copyWith(
                color: AppColor.accentTextColor,
              ),
        ),
      ],
    );
  }
}
