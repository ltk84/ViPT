import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class DishCategoryListScreen extends StatelessWidget {
  const DishCategoryListScreen({Key? key}) : super(key: key);

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
          //final cate = _controller.workoutCategories[index];
          // return CustomTile(
          //   level: 1,
          //   asset: '${JPGAssetString.path}/${cate.asset}',
          //   onPressed: () {
          //     // _navigateToSuitableScreen(cate);
          //     _controller.loadContent(cate);
          //   },
          //   title: cate.name,
          //   description:
          //       '${_controller.workoutCategories[index].countLeaf()} bài tập',
          // );
          return CustomTile(
            level: 1,
            asset: PNGAssetString.jackfruitPotatoStew,
            onPressed: () {
              Get.toNamed(Routes.dishList);
            },
            title: 'Ăn chay $index',
            description: '${index * 10} món ăn',
          );
        },
        separatorBuilder: (_, index) {
          return const Divider(
            indent: 24,
          );
        },
        //itemCount: _controller.workoutCategories.length,
        itemCount: 10,
      ),
    );
  }
}
