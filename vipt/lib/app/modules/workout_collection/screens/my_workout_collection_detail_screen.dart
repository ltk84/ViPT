import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/modules/workout_collection/widgets/collection_setting_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class MyWorkoutCollectionDetailScreen extends StatelessWidget {
  MyWorkoutCollectionDetailScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

  void handleBackAction() {
    _controller.updateCollectionSetting();
    _controller.resetCaloAndTime();
  }

  void init() {
    _controller.loadCollectionSetting();
    // _controller.loadWorkoutList();
  }

  void handleDeleteAction() async {
    await _controller.deleteUserCollection();
    handleBackAction();
  }

  @override
  Widget build(BuildContext context) {
    init();

    return WillPopScope(
      onWillPop: () async {
        handleBackAction();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.toNamed(Routes.previewExerciseList);
          },
          isExtended: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          label: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Text(
              'Bắt đầu luyện tập'.tr,
              style: Theme.of(context).textTheme.button,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Hero(
              tag: 'leadingButtonAppBar',
              child: Icon(Icons.arrow_back_ios_new_rounded),
            ),
            onPressed: () {
              handleBackAction();
              Navigator.of(context).pop();
            },
          ),
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          actions: [
            IconButton(
              color: Theme.of(context).backgroundColor,
              icon: Hero(
                tag: 'actionButtonAppBar_2',
                child: Icon(
                  Icons.delete_rounded,
                  color: AppColor.textColor,
                ),
              ),
              onPressed: () {
                handleDeleteAction();
              },
            ),

            // này phải check thêm xem collection này là custom hay default.

            IconButton(
              color: Theme.of(context).backgroundColor,
              icon: Hero(
                tag: 'actionButtonAppBar',
                child: Icon(
                  Icons.settings_rounded,
                  color: AppColor.textColor,
                ),
              ),
              onPressed: () async {
                final result = await Get.toNamed(Routes.editWorkoutCollection);
                if (result != null) {
                  await _controller.editUserCollection(result);
                  init();
                  _controller.calculateCaloAndTime();
                }
              },
            ),
          ],
        ),
        body: Container(
          padding: AppDecoration.screenPadding.copyWith(top: 8, bottom: 0),
          child: LayoutBuilder(builder: (context, constraints) {
            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                _buildIntro(context),
                const SizedBox(
                  height: 8,
                ),
                _buildIndicatorDisplay(context),
                const SizedBox(
                  height: 16,
                ),
                GetBuilder<WorkoutCollectionController>(
                  builder: (_) => CollectionSettingWidget(
                    maxHeight: constraints.maxHeight,
                    controller: _controller,
                    showShuffleTile: true,
                    enabled: _controller.workoutList.isNotEmpty,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildExerciseList(context),
                SizedBox(
                  height: Theme.of(context).textTheme.button!.fontSize! * 4,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildIntro(context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            _controller.selectedCollection!.title.tr,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        if (_controller.selectedCollection!.description != "")
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              _controller.selectedCollection!.description.tr,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
      ],
    );
  }

  Widget _buildIndicatorDisplay(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 25,
            maxHeight: 25,
          ),
          child: SvgPicture.asset(
            SVGAssetString.timer,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Obx(
          () => Text(
            '${_controller.timeValue.value.toInt()} phút'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        SizedBox(
          height: 28,
          child: VerticalDivider(
            color: AppColor.textColor,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 25,
            maxHeight: 25,
          ),
          child: SvgPicture.asset(
            SVGAssetString.fire,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Obx(
          () => Text(
            '${_controller.caloValue.value.toInt()} calo'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseList(context) {
    return GetBuilder<WorkoutCollectionController>(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Danh sách bài tập'.tr,
              style: Theme.of(context).textTheme.headline3),
          const SizedBox(
            height: 4,
          ),
          ..._controller.generatedWorkoutList.map(
            (workout) => Obx(
              () => ExerciseInCollectionTile(
                asset: workout.thumbnail,
                title: workout.name,
                description:
                    '${_controller.collectionSetting.value.exerciseTime} giây',
                onPressed: () {
                  Get.toNamed(Routes.exerciseDetail, arguments: workout);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
