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
      body: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (_, index) {
            if (index == 0) {
              return GetBuilder<WorkoutCollectionController>(
                builder: (_) => CustomTile(
                  level: 1,
                  asset: JPGAssetString.yourWorkoutCollection,
                  onPressed: () {
                    Get.toNamed(Routes.myWorkoutCollectionList);
                  },
                  title: 'Bộ luyện tập của bạn',
                  description:
                      '${_controller.userCollections.length} bộ bài tập',
                ),
              );
            }
            final cate = _controller.collectionCategories[index - 1];
            return CustomTile(
              level: 1,
              asset: '${JPGAssetString.path}/${cate.asset}',
              onPressed: () {
                _controller.loadCollectionListBaseOnCategory(cate);
              },
              title: cate.name.tr,
              description:
                  '${_controller.cateListAndNumCollection[cate.id]} bộ bài tập',
            );
          },
          separatorBuilder: (_, index) => const Divider(
                indent: 24,
              ),
          itemCount: _controller.collectionCategories.length + 1),
    );
  }
}
