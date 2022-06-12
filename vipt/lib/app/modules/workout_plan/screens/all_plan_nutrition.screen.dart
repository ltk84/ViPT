import 'package:flutter/material.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/data/models/nutrition.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/global_widgets/loading_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';

class AllPlanNutritionScreen extends StatelessWidget {
  final List<MealNutrition> nutritionList;
  final Function(MealNutrition) elementOnPress;
  final DateTime startDate;
  final bool isLoading;
  const AllPlanNutritionScreen(
      {Key? key,
      required this.startDate,
      required this.nutritionList,
      required this.elementOnPress,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: isLoading
          ? const LoadingWidget()
          : Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      AppBarIconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        iconData: Icons.close,
                        hero: '',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'DANH SÁCH BỮA ĂN',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: _buildNutritionList(
                      context,
                      startDate: startDate,
                      nutritionList: nutritionList,
                      elementOnPress: elementOnPress,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _buildNutritionList(context,
      {required DateTime startDate,
      required List<MealNutrition> nutritionList,
      required Function(MealNutrition) elementOnPress}) {
    int collectionPerDay = 3;
    List<Widget> results = [];

    int count = nutritionList.length;
    for (int i = 0; i < count; i++) {
      DateTime nutritionDate =
          startDate.add(Duration(days: i ~/ collectionPerDay));
      Nutrition nutrition = nutritionList[i];

      Widget collectionToWidget = Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ExerciseInCollectionTile(
            asset: (nutrition as MealNutrition).meal.asset == ''
                ? JPGAssetString.meal
                : nutrition.meal.asset,
            title: nutrition.getName(),
            description: nutrition.calories.toStringAsFixed(0) + ' kcal',
            onPressed: () {
              elementOnPress(nutrition);
            }),
      );

      if (i % collectionPerDay == 0) {
        Widget dayIndicator = Padding(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  Text(
                    'NGÀY ${i ~/ collectionPerDay + 1}',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${nutritionDate.day}/${nutritionDate.month}/${nutritionDate.year}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.textColor.withOpacity(
                            AppColor.subTextOpacity,
                          ),
                        ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
            ],
          ),
        );

        results.add(dayIndicator);
      }

      results.add(collectionToWidget);
    }

    return results;
  }
}
