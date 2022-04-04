import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/modules/nutrition/nutrition_controller.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class DishListScreen extends StatelessWidget {
  DishListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<NutritionController>();
  final Category cate = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            cate.name.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (_, index) {
          final meal = _controller.meals[index];
          final nutrition = MealNutrition(meal: meal);
          return FutureBuilder(
              future: nutrition.getIngredients(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return SizedBox(
                    width: 200.0,
                    height: 100.0,
                    child: Shimmer.fromColors(
                      baseColor: AppColor.textColor,
                      highlightColor: AppColor.textColor,
                      child: CustomTile(
                        type: 3,
                        asset: '',
                        title: '',
                        description: ' ',
                        onPressed: () {},
                      ),
                    ),
                  );
                }
                return CustomTile(
                  type: 3,
                  asset: nutrition.meal.asset,
                  onPressed: () {
                    Get.toNamed(Routes.dishDetail, arguments: nutrition);
                  },
                  title: meal.name,
                  description: '${nutrition.calories.toInt()} kcal',
                );
              });
        },
        separatorBuilder: (_, index) => const Divider(
          indent: 24,
        ),
        //itemCount: _controller.workouts.length),
        itemCount: _controller.meals.length,
      ),
    );
  }
}
