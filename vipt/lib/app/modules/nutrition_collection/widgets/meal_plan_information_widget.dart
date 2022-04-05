import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/global_widgets/indicator_display_widget.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';

class MealPlanInformationWidget extends StatelessWidget {
  final MealCollection mealPlan;
  const MealPlanInformationWidget({Key? key, required this.mealPlan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppDecoration.screenPadding.copyWith(top: 32, bottom: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          IntroCollectionWidget(
              title: mealPlan.title, description: mealPlan.description),
          const SizedBox(
            height: 8,
          ),
          IndicatorDisplayWidget(
            displayTime: '${mealPlan.dateToMealID.length} ngày',
            onlyTime: true,
            dateTime: true,
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
          _buildIntakeCaloriesDisplay(context, 1500),
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
          _buildNutritionFacts(context, protein: 100, carbs: 800, fat: 30),
        ],
      ),
    );
  }

  Widget _buildNutritionFacts(context,
      {required num carbs, required num protein, required num fat}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InfoCubeWidget(
          title: '${carbs.toStringAsFixed(0)}g',
          subtitle: 'Carbs',
          color: AppColor.carbCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        const SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          title: '${protein.toStringAsFixed(0)}g',
          subtitle: 'Protein',
          color: AppColor.proteinCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
        const SizedBox(
          width: 24,
        ),
        InfoCubeWidget(
          title: '${fat.toStringAsFixed(0)}g',
          subtitle: 'Fat',
          color: AppColor.fatCubeColor,
          textColor: AppColor.buttonForegroundColor,
        ),
      ],
    );
  }

  Widget _buildIntakeCaloriesDisplay(context, num amount) {
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
              'Calories mỗi ngày',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              '${amount.toStringAsFixed(0)} kcal',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ],
    );
  }
}
