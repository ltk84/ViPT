import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/global_widgets/indicator_display_widget.dart';
import 'package:vipt/app/global_widgets/info_cube_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';

class DishInformationWidget extends StatelessWidget {
  const DishInformationWidget({Key? key, required this.mealNutrition})
      : super(key: key);
  final MealNutrition mealNutrition;

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
              title: mealNutrition.meal.name.tr,
              description: mealNutrition.getMealCate()),
          const SizedBox(
            height: 8,
          ),
          IndicatorDisplayWidget(
            displayTime: '${mealNutrition.meal.cookTime} phút',
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
          _buildIntakeCaloriesDisplay(context, mealNutrition.calories),
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
          _buildNutritionFacts(context,
              protein: mealNutrition.protein,
              carbs: mealNutrition.carbs,
              fat: mealNutrition.fat),
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
              'Calories',
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
