import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/nutrition_collection/widgets/meal_plan_tile.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class MealPlanListScreen extends StatelessWidget {
  const MealPlanListScreen({Key? key}) : super(key: key);

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
              'Kế hoạch dinh dưỡng'.tr,
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            MealPlanTile(
              onPressed: () {
                Get.toNamed(Routes.mealPlanDetail);
              },
              asset:
                  'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
              title: 'Ăn chay'.tr,
              description: '7 ngày'.tr,
            ),
            const Divider(
              indent: 24,
            ),
          ],
        ));
  }
}
