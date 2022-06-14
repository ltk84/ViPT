import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/nutrition/nutrition_controller.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';

class DishCategoryListScreen extends StatelessWidget {
  DishCategoryListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<NutritionController>();

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
            'Món ăn'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (_, index) {
          final mealCate = _controller.mealCategories[index];
          return CustomTile(
            type: 1,
            asset: '${PNGAssetString.path}/${mealCate.asset}',
            onPressed: () {
              _controller.loadContent(mealCate);
            },
            title: mealCate.name,
            description: '${mealCate.countLeaf()} món ăn',
          );
        },
        separatorBuilder: (_, index) {
          return const Divider(
            indent: 24,
          );
        },
        //itemCount: _controller.workoutCategories.length,
        itemCount: _controller.mealCategories.length,
      ),
    );
  }
}
