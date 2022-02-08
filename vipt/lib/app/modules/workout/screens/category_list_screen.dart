import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/providers/workout_category_provider.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout/screens/exercise_list_screen.dart';
import 'package:vipt/app/modules/workout/workout_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class CategoryListScreen extends StatelessWidget {
  CategoryListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutController>();

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
            'Bài tập'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      // body: ListView(
      //   physics: const BouncingScrollPhysics(
      //       parent: AlwaysScrollableScrollPhysics()),
      //   children: _buildExerciseCategory(context),
      // ),
      body: ListView.separated(
          itemBuilder: (_, index) {
            final cate = _controller.workoutCategories[index];
            return CustomTile(
              level: 1,
              asset: SVGAssetString.gym,
              onPressed: () {
                _navigateToSuitableScreen(cate);
              },
              title: cate.name,
              description: '24 bài tập',
            );
          },
          separatorBuilder: (_, index) {
            return const Divider(
              indent: 24,
            );
          },
          itemCount: _controller.cateListAndNumWorkout.keys.length),
    );
  }

  void _navigateToSuitableScreen(WorkoutCategory cate) {
    if (cate.parentCategoryID == null) {
      _controller.loadChildCategoriesBaseOnParentCategory(cate.id ?? '');
      Get.toNamed(Routes.workoutCategory);
    } else {
      _controller.loadChildCategoriesBaseOnParentCategory(cate.id ?? '');
      Get.toNamed(Routes.exerciseList);
    }
  }

  List<Widget> _buildExerciseCategory(context) {
    return [
      CustomTile(
        level: 1,
        asset: SVGAssetString.gym,
        onPressed: () {
          Get.toNamed(Routes.exerciseList);
        },
        title: 'Abs',
        description: '24 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
      CustomTile(
        level: 1,
        asset: SVGAssetString.boxing,
        onPressed: () {},
        title: 'Legs',
        description: '32 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
    ];
  }

  List<Widget> _buildWorkoutCollectionCategory() {
    return [
      CustomTile(
        level: 1,
        asset: SVGAssetString.gym,
        onPressed: () {},
        title: 'Bộ luyện tập của bạn',
        description: '24 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
      CustomTile(
        level: 1,
        asset: SVGAssetString.boxing,
        onPressed: () {},
        title: 'Cardio',
        description: '32 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
      CustomTile(
        level: 1,
        asset: SVGAssetString.boxing,
        onPressed: () {},
        title: 'Stretching',
        description: '32 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
      CustomTile(
        level: 1,
        asset: SVGAssetString.boxing,
        onPressed: () {},
        title: 'Fighting',
        description: '32 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
    ];
  }
}
