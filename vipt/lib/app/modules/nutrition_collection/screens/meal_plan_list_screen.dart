import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/modules/nutrition_collection/nutrition_collection_controller.dart';
import 'package:vipt/app/modules/nutrition_collection/widgets/meal_plan_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class MealPlanListScreen extends StatelessWidget {
  MealPlanListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<NutritionCollectionController>();

  @override
  Widget build(BuildContext context) {
    List<MealCollection> mealCollections = _controller.mealCollectionList;
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
            'Kế hoạch dinh dưỡng'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: mealCollections.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                MealPlanTile(
                  onPressed: () {
                    Get.toNamed(Routes.mealPlanDetail,
                        arguments: mealCollections[index]);
                  },
                  asset:
                      'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
                  title: mealCollections[index].title,
                  description:
                      '${mealCollections[index].dateToMealID.length} ngày'.tr,
                ),
                const Divider(
                  indent: 24,
                ),
              ],
            );
          }),
    );
  }
}
