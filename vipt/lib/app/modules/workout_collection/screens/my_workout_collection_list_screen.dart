import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class MyWorkoutCollectionListScreen extends StatelessWidget {
  MyWorkoutCollectionListScreen({Key? key}) : super(key: key);

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
            'Bộ luyện tập của bạn'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).backgroundColor,
            icon: Hero(
              tag: 'actionButtonAppBar',
              child: Icon(
                Icons.add,
                color: AppColor.textColor,
              ),
            ),
            onPressed: () {
              Get.toNamed(Routes.addWorkoutCollection);
            },
          ),
        ],
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (_, index) {
            var collection = _controller.userCollections[index];
            return CustomTile(
              level: 2,
              asset: SVGAssetString.gym,
              onPressed: () {
                Get.toNamed(Routes.myWorkoutCollectionDetail,
                    arguments: collection);
              },
              title: collection.title,
            );
          },
          separatorBuilder: (_, index) => const Divider(
                indent: 24,
              ),
          itemCount: _controller.userCollections.length),
    );
  }
}
