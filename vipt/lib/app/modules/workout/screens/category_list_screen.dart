import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout/workout_controller.dart';

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
      body: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (_, index) {
            final cate = _controller.workoutCategories[index];
            return CustomTile(
              level: 1,
              asset: '${JPGAssetString.path}/${cate.asset}',
              onPressed: () {
                // _navigateToSuitableScreen(cate);
                _controller.loadContent(cate);
              },
              title: cate.name,
              description:
                  '${_controller.workoutCategories[index].countLeaf()} bài tập',
            );
          },
          separatorBuilder: (_, index) {
            return const Divider(
              indent: 24,
            );
          },
          itemCount: _controller.workoutCategories.length),
    );
  }

  // void _navigateToSuitableScreen(Category cate) {
  //   if (cate.isRootCategory() &&
  //       DataService.instance.checkIfWorkoutCategoryHasChild(cate)) {
  //     _controller.loadChildCategoriesBaseOnParentCategory(cate.id ?? '');
  //   } else {
  //     _controller.loadWorkoutListBaseOnCategory(cate);
  //   }
  // }
}
