import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:get/get.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionCategoryListScreen extends StatelessWidget {
  WorkoutCollectionCategoryListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

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
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: _buildWorkoutCollectionCategory(context),
      ),
    );
  }

  List<Widget> _buildWorkoutCollectionCategory(context) {
    return [
      CustomTile(
        level: 1,
        asset: SVGAssetString.gym,
        onPressed: () {
          Get.toNamed(Routes.myWorkoutCollectionList);
        },
        title: 'Bộ luyện tập của bạn',
        description: '24 bài tập',
      ),
      const Divider(
        indent: 24,
      ),
      CustomTile(
        level: 1,
        asset: SVGAssetString.boxing,
        onPressed: () {
          Get.toNamed(Routes.workoutCollectionList);
        },
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
