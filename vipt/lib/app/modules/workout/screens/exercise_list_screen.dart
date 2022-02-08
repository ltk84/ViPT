import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout/screens/exercise_detail_screen.dart';
import 'package:vipt/app/routes/pages.dart';

class ExerciseListScreen extends StatelessWidget {
  const ExerciseListScreen({Key? key}) : super(key: key);

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
            'Tên danh mục'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: _buildExerciseList(context),
      ),
    );
  }

  List<Widget> _buildExerciseList(context) {
    return [
      CustomTile(
        level: 2,
        asset: SVGAssetString.gym,
        onPressed: () {
          Get.toNamed(Routes.exerciseDetail);
        },
        title: 'Bài tập ABC',
      ),
      const Divider(
        indent: 24,
      ),
      CustomTile(
        level: 2,
        asset: SVGAssetString.boxing,
        onPressed: () {},
        title: 'DEF GHI',
      ),
      const Divider(
        indent: 24,
      ),
    ];
  }
}
