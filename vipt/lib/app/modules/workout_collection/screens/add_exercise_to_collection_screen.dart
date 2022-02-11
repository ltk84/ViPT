import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_one_column_layout.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/widgets/search_field_widget.dart';
import 'package:vipt/app/routes/pages.dart';

class AddExerciseToCollectionScreen extends StatelessWidget {
  const AddExerciseToCollectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.close_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Thêm bài tập'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).backgroundColor,
            icon: const Hero(
              tag: 'actionButtonAppBar',
              child: Icon(
                Icons.check_rounded,
                color: AppColor.secondaryColor,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: SearchFieldWidget(
                textStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 16)),
          ),
          Divider(
            height: 0,
            color: AppColor.textFieldUnderlineColor,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            height: _maxHeight * 0.6,
            // child: ListView(
            //   physics: const BouncingScrollPhysics(
            //       parent: AlwaysScrollableScrollPhysics()),
            //   children: [
            //     _buildExerciseList(context),
            //   ],
            // ),
            child: MultipleChoiceOneColumnLayout(listAnswers: []),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExerciseInCollectionTile(
          asset: SVGAssetString.boxing,
          title: 'Đánh lộn nè',
          description: '10 giây',
          onPressed: () {},
        ),
        const SizedBox(
          height: 4,
        ),
        ExerciseInCollectionTile(
          asset: SVGAssetString.boxing,
          title: 'Đánh lộn nè 2',
          description: '10 giây',
          onPressed: () {},
        ),
        const SizedBox(
          height: 4,
        ),
        ExerciseInCollectionTile(
          asset: SVGAssetString.boxing,
          title: 'Đánh lộn nè 3',
          description: '10 giây',
          onPressed: () {},
        ),
      ],
    );
  }
}
