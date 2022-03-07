import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
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
        backgroundColor: Colors.transparent,
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
          leading: AppBarIconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              hero: 'leadingButtonAppBar',
              iconData: Icons.arrow_back_ios_new_rounded,
              onPressed: () {
                handleBackAction();
                Navigator.of(context).pop();
              }),
          actions: [
            AppBarIconButton(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                hero: 'actionButtonAppBar1',
                iconData: Icons.delete_rounded,
                onPressed: () {
                  handleDeleteAction();
                }),
            // này phải check thêm xem collection này là custom hay default.
            AppBarIconButton(
                padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                hero: 'actionButtonAppBar2',
                iconData: Icons.settings_rounded,
                onPressed: () async {
                  final result =
                      await Get.toNamed(Routes.editWorkoutCollection);
                  if (result != null) {
                    await _controller.editUserCollection(result);
                    init();
                    _controller.calculateCaloAndTime();
                  }
                }),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage(JPGAssetString.workout_1),
              fit: BoxFit.cover,
            ),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                Container(
                  margin: EdgeInsets.only(top: constraints.maxHeight * 0.15),
                  padding:
                      AppDecoration.screenPadding.copyWith(top: 24, bottom: 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
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
                        height:
                            Theme.of(context).textTheme.button!.fontSize! * 4,
                      ),
                    ],
                  ),
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
            '${_controller.displayTime}'.tr,
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
          Text(
            'Danh sách này thay đổi dựa vào số bài tập mỗi vòng.'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
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
