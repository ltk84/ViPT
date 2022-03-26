import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/global_widgets/indicator_display_widget.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';

class DishInformationWidget extends StatelessWidget {
  const DishInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: constraints.maxHeight * 0.15),
      padding: AppDecoration.screenPadding.copyWith(top: 32, bottom: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          IntroCollectionWidget(
              title: "Mít hầm khoai tây".tr, description: 'Ăn chay'),
          const SizedBox(
            height: 8,
          ),
          const IndicatorDisplayWidget(
            displayTime: '45 phút',
            onlyTime: true,
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Divider(
              color:
                  AppColor.textColor.withOpacity(AppColor.disabledTextOpacity),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _buildIntakeCaloriesDisplay(context, '100'),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Divider(
              color:
                  AppColor.textColor.withOpacity(AppColor.disabledTextOpacity),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          _buildNutritionFacts(context),
        ],
      ),
    );
  }

  Widget _buildNutritionFacts(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        InfoCubeWidget(
          title: '50g',
          subtitle: 'Carbs',
          color: AppColor.carbCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          title: '50g',
          subtitle: 'Carbs',
          color: AppColor.proteinCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          title: '50g',
          subtitle: 'Carbs',
          color: AppColor.fatCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
      ],
    );
  }

  Widget _buildIntakeCaloriesDisplay(context, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          SVGAssetString.dish,
          height: 24,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calories',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '$amount kcal',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ],
    );
  }
}
