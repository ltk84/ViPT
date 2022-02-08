import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/modules/profile/screens/exercise_list_screen.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

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
        children: _buildExerciseCategory(context),
      ),
    );
  }

  List<Widget> _buildExerciseCategory(context) {
    return [
      CustomTile(
        level: 1,
        asset: SVGAssetString.gym,
        onPressed: () {
          pushNewScreen(
            context,
            screen: ExerciseListScreen(),
            withNavBar: true, // OPTIONAL VALUE. True by default.
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
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