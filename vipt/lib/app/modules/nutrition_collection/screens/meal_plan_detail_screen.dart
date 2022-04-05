import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/modules/nutrition_collection/nutrition_collection_controller.dart';
import 'package:vipt/app/modules/nutrition_collection/widgets/meal_plan_dishes_widget.dart';
import 'package:vipt/app/modules/nutrition_collection/widgets/meal_plan_information_widget.dart';

class MealPlanDetailScreen extends StatelessWidget {
  MealPlanDetailScreen({Key? key}) : super(key: key);

  final _controller = Get.find<NutritionCollectionController>();

  @override
  Widget build(BuildContext context) {
    final MealCollection mealPlan = Get.arguments;
    _controller.setCurrentCollection(mealPlan);
    return Scaffold(
      backgroundColor: AppColor.secondaryBackgroudColor,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: AppBarIconButton(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  hero: 'leadingButtonAppBar',
                  iconData: Icons.arrow_back_ios_new_rounded,
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              pinned: true,
              expandedHeight: Get.size.height * 0.36,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildImage(),
              ),
            ),
            FutureBuilder(
                future: _controller.fetchMealNutritionList(),
                builder: (context, snapshot) {
                  return SliverList(
                    delegate: SliverChildListDelegate([
                      MealPlanInformationWidget(
                        mealPlan: mealPlan,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      if (snapshot.connectionState == ConnectionState.done)
                        ...mealPlan.dateToMealID.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: MealPlanDishesWidget(
                              day: entry.key,
                              dishes: _controller.getMealListByDay(entry.key),
                            ),
                          );
                        }).toList(),
                      const SizedBox(
                        height: 24,
                      ),
                    ]),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: CachedNetworkImage(
        imageUrl:
            'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
        fit: BoxFit.fitHeight,
        progressIndicatorBuilder: (context, url, loadingProgress) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
              value: loadingProgress.progress,
            ),
          );
        },
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
