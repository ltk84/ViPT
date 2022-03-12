import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/global_widgets/asset_image_background_container.dart';
import 'package:vipt/app/global_widgets/exercise_list_widget.dart';
import 'package:vipt/app/global_widgets/indicator_display_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/collection_setting_widget.dart';
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
        body: AssetImageBackgroundContainer(
          imageURL: JPGAssetString.userWorkoutCollection,
          child: Column(
            children: [
              IntroCollectionWidget(
                  title: _controller.selectedCollection!.title.tr,
                  description: _controller.selectedCollection!.description.tr),
              const SizedBox(
                height: 8,
              ),
              Obx(() {
                return IndicatorDisplayWidget(
                  displayTime: '${_controller.displayTime}'.tr,
                  displayCaloValue:
                      '${_controller.caloValue.value.toInt()} calo'.tr,
                );
              }),
              const SizedBox(
                height: 24,
              ),
              Obx(() {
                return ExerciseListWidget(
                    workoutList: _controller.generatedWorkoutList,
                    displayExerciseTime:
                        '${_controller.collectionSetting.value.exerciseTime} giây');
              }),
              SizedBox(
                height: Theme.of(context).textTheme.button!.fontSize! * 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
