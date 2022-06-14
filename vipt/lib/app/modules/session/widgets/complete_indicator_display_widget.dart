import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';

class CompleteIndicatorDisplayWidget extends StatelessWidget {
  final String timeString;
  final String exerciseCountString;
  final String caloString;
  final String timeUnit;

  const CompleteIndicatorDisplayWidget(
      {Key? key,
      required this.timeString,
      required this.timeUnit,
      required this.exerciseCountString,
      required this.caloString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildIndicator(
          context,
          asset: SVGAssetString.timer,
          value: timeString,
          unit: timeUnit.tr,
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          height: 28,
          child: VerticalDivider(
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        _buildIndicator(
          context,
          asset: SVGAssetString.yoga_2,
          value: exerciseCountString,
          unit: 'bài tập'.tr,
        ),
        const SizedBox(
          width: 16,
        ),
        SizedBox(
          height: 28,
          child: VerticalDivider(
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        _buildIndicator(
          context,
          asset: SVGAssetString.fire,
          value: caloString,
          unit: 'calo'.tr,
        ),
      ],
    );
  }

  Widget _buildIndicator(context,
      {required String asset, required String value, required String unit}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 25,
                maxHeight: 25,
              ),
              child: SvgPicture.asset(
                asset,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            unit,
            style: Theme.of(context).textTheme.subtitle2,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
