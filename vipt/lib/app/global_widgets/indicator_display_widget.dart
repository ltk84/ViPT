import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';

class IndicatorDisplayWidget extends StatelessWidget {
  final String displayTime;
  final String displayCaloValue;
  final bool onlyTime;

  const IndicatorDisplayWidget(
      {Key? key,
      required this.displayTime,
      this.displayCaloValue = '',
      this.onlyTime = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 25,
            maxHeight: 25,
          ),
          child: SvgPicture.asset(
            SVGAssetString.timer,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          displayTime,
          style: Theme.of(context).textTheme.headline6,
        ),
        if (!onlyTime)
          const SizedBox(
            width: 8,
          ),
        if (!onlyTime)
          SizedBox(
            height: 28,
            child: VerticalDivider(
              color: AppColor.textColor,
            ),
          ),
        if (!onlyTime)
          const SizedBox(
            width: 8,
          ),
        if (!onlyTime)
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 25,
              maxHeight: 25,
            ),
            child: SvgPicture.asset(
              SVGAssetString.fire,
            ),
          ),
        if (!onlyTime)
          const SizedBox(
            width: 8,
          ),
        if (!onlyTime)
          Text(
            displayCaloValue,
            style: Theme.of(context).textTheme.headline6,
          ),
      ],
    );
  }
}
