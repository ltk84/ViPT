import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/workout_collection/widgets/custom_draggable_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/routes/pages.dart';

import '../workout_collection_controller.dart';

class PreviewExerciseList extends StatelessWidget {
  PreviewExerciseList({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(Routes.workoutSession);
        },
        isExtended: true,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        label: SizedBox(
          width: screenSize.width * 0.75,
          child: Text(
            'Bắt đầu luyện tập'.tr,
            style: Theme.of(context).textTheme.button,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.accentTextColor,
            ),
          ),
          onPressed: () {
            // handleBackAction();
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
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        children: [
          Column(
            children: [
              SizedBox(
                height: screenSize.height * 0.10,
              ),
              _buildIntro(context),
              const SizedBox(
                height: 4,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: screenSize.height * 0.7),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Text(
                          "BÀI TẬP MỖI VÒNG".tr,
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Số vòng: ${_controller.collectionSetting.value.round}'
                              .tr,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColor.textColor.withOpacity(
                                      AppColor.subTextOpacity,
                                    ),
                                  ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Divider(
                          thickness: 1,
                          color: AppColor.textFieldUnderlineColor,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildShuffleButton(context),
                        _buildExerciseList(context),
                        SizedBox(
                          height:
                              Theme.of(context).textTheme.button!.fontSize! *
                                  3.5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIntro(context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            'Xem trước bài tập'.tr,
            style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: AppColor.accentTextColor,
                ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            'Giữ & kéo thả để thay đổi thứ tự bài tập'.tr,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: AppColor.accentTextColor,
                ),
          ),
        ),
      ],
    );
  }

  Widget _buildShuffleButton(context) {
    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          _controller.generateRandomList();
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shuffle_rounded,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8),
              Text(
                'Nhấn để xáo trộn thứ tự'.tr,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseList(context) {
    return GetBuilder<WorkoutCollectionController>(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._controller.generatedWorkoutList.map((workout) {
            int index = _controller.generatedWorkoutList.indexOf(workout);
            Widget workoutTile = Obx(
              () => Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: ExerciseInCollectionTile(
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
            );
            if ((index + 1) %
                        _controller.collectionSetting.value.restFrequency ==
                    0 &&
                _controller.generatedWorkoutList.length != index + 1) {
              return Column(
                children: [
                  CustomDraggableWidget(child: workoutTile),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 28,
                        child: Divider(
                          thickness: 1,
                          color: AppColor.textFieldUnderlineColor,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Nghỉ ${_controller.collectionSetting.value.restTime} giây',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.textColor.withOpacity(
                                AppColor.subTextOpacity,
                              ),
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      SizedBox(
                        width: 28,
                        child: Divider(
                          thickness: 1,
                          color: AppColor.textFieldUnderlineColor,
                        ),
                      ),
                    ],
                  )
                ],
              );
            }
            return CustomDraggableWidget(child: workoutTile);
          }),
        ],
      ),
    );
  }
}
