import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/global_widgets/exercise_list_widget.dart';
import 'package:vipt/app/global_widgets/network_image_background_container.dart';
import 'package:vipt/app/global_widgets/indicator_display_widget.dart';
import 'package:vipt/app/global_widgets/intro_collection_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/collection_setting_widget.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionDetailScreen extends StatelessWidget {
  WorkoutCollectionDetailScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

  void onLeaveScreen() {
    _controller.updateCollectionSetting();
    _controller.resetCaloAndTime();
  }

  void init() {
    _controller.loadCollectionSetting();
    // _workoutList = _controller.loadWorkoutList(_collection.workoutIDs);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return WillPopScope(
      onWillPop: () async {
        onLeaveScreen();
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            // onLeaveScreen();
            // init();
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
          actions: [
            AppBarIconButton(
                iconData: Icons.access_time_filled_sharp,
                onPressed: () {
                  Get.toNamed(Routes.workoutSession);
                },
                hero: 'actionAppBarButton'),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: AppBarIconButton(
              padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
              hero: 'leadingButtonAppBar',
              iconData: Icons.arrow_back_ios_new_rounded,
              onPressed: () {
                onLeaveScreen();
                Navigator.of(context).pop();
              }),
        ),
        body: NetworkImageBackgroundContainer(
          imageURL: _controller.selectedCollection == null
              ? ''
              : _controller.selectedCollection!.asset,
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
                        '${_controller.caloValue.value.toInt()} calo'.tr);
              }),
              const SizedBox(
                height: 16,
              ),
              CollectionSettingWidget(
                controller: _controller,
                enabled: _controller.workoutList.isNotEmpty,
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(() {
                return ExerciseListWidget(
                  workoutList: _controller.generatedWorkoutList,
                  displayExerciseTime:
                      '${_controller.collectionSetting.value.exerciseTime} giây',
                );
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
