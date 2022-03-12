import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';

class IndicatorDisplayWidget extends StatelessWidget {
  final String displayTime;
  final String displayCaloValue;

  const IndicatorDisplayWidget(
      {Key? key, required this.displayTime, required this.displayCaloValue})
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
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          height: 28,
          child: VerticalDivider(
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 25,
            maxHeight: 25,
          ),
          child: SvgPicture.asset(
            SVGAssetString.fire,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          displayCaloValue,
          style: Theme.of(context).textTheme.headline6,
        ),
      ],
    );
  }
}
