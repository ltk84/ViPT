import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/modules/workout_collection/widgets/collection_setting_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/widgets/property_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionDetailScreen extends StatelessWidget {
  WorkoutCollectionDetailScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutCollectionController>();

  void handleBackAction() {
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
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.workoutSession);
                },
                icon: Icon(Icons.access_time_filled_sharp))
          ],
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
                CollectionSettingWidget(
                  maxHeight: constraints.maxHeight,
                  controller: _controller,
                  enabled: _controller.generatedWorkoutList.isNotEmpty,
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
              textAlign: TextAlign.center,
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
          height: 26,
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

  Widget _buildRoundProperty(context, maxHeight, enabled) {
    return PropertyTile(
      enabled: enabled,
      onTap: () {
        _showSelection(
          context,
          maxHeight: maxHeight,
          itemBuilder: (context, index) {
            if (index > 0) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            }
          },
          initialValue: _controller.collectionSetting.value.round,
          onSelectedItemChanged: (value) {
            _controller.collectionSetting.update((val) {
              val!.round = value;
            });
          },
        );
      },
      title: 'Số vòng'.tr,
      trailing: _controller.collectionSetting.value.round.toString(),
      iconData: Icons.repeat_rounded,
    );
  }

  Widget _buildNumOfWorkoutPerRoundProperty(context, maxHeight, enabled) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.looks_3_outlined,
      onTap: () {
        _showSelection(
          context,
          maxHeight: maxHeight,
          itemBuilder: (context, index) {
            if (index > 0 && index <= _controller.maxWorkout.value) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            }
          },
          initialValue:
              _controller.collectionSetting.value.numOfWorkoutPerRound,
          onSelectedItemChanged: (value) {
            _controller.collectionSetting.update((val) {
              val!.numOfWorkoutPerRound = value;
            });
            _controller.generateRandomList();
          },
        );
      },
      title: 'Số bài tập mỗi vòng'.tr,
      trailing:
          _controller.collectionSetting.value.numOfWorkoutPerRound.toString(),
    );
  }

  Widget _buildWarmUpProperty(context, enabled) {
    Color disabledColor =
        AppColor.textColor.withOpacity(AppColor.disabledTextOpacity);

    return Obx(
      () => SwitchListTile(
        activeColor: Theme.of(context).primaryColor,
        onChanged: enabled
            ? (bool value) {
                _controller.collectionSetting.update((val) {
                  val!.isStartWithWarmUp = value;
                });
              }
            : null,
        value: _controller.collectionSetting.value.isStartWithWarmUp,
        tileColor: AppColor.listTileButtonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        secondary: Icon(
          Icons.emoji_people_rounded,
          color: enabled ? AppColor.textColor : disabledColor,
        ),
        title: Text(
          'Bắt đầu với khởi động'.tr,
          style: enabled
              ? Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w500)
              : Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.w500, color: disabledColor),
        ),
      ),
    );
  }

  // Widget _buildShuffleProperty(context) {
  //   return Obx(
  //     () => SwitchListTile(
  //       activeColor: Theme.of(context).primaryColor,
  //       onChanged: (bool value) {
  //         _controller.collectionSetting.update((val) {
  //           val!.isShuffle = value;
  //         });
  //       },
  //       value: _controller.collectionSetting.value.isShuffle,
  //       tileColor: AppColor.listTileButtonColor,
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(8),
  //         ),
  //       ),
  //       secondary: Icon(
  //         Icons.shuffle_rounded,
  //         color: AppColor.textColor,
  //       ),
  //       title: Text(
  //         'Trộn ngẫu nhiên'.tr,
  //         style: Theme.of(context)
  //             .textTheme
  //             .bodyText2!
  //             .copyWith(fontWeight: FontWeight.w500),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildExerciseTimeProperty(context, maxHeight, enabled) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.timelapse_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$index giây',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: _controller.collectionSetting.value.exerciseTime,
            onSelectedItemChanged: (value) {
              _controller.collectionSetting.update((val) {
                val!.exerciseTime = value;
              });
            });
      },
      title: 'Thời gian mỗi bài'.tr,
      trailing: '${_controller.collectionSetting.value.exerciseTime} giây'.tr,
    );
  }

  Widget _buildTransitionTimeProperty(context, maxHeight, enabled) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.sync_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$index giây',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: _controller.collectionSetting.value.transitionTime,
            onSelectedItemChanged: (value) {
              _controller.collectionSetting.update((val) {
                val!.transitionTime = value;
              });
            });
      },
      title: 'Thời gian chuyển'.tr,
      trailing: '${_controller.collectionSetting.value.transitionTime} giây'.tr,
    );
  }

  Widget _buildRestTimeProperty(context, maxHeight, enabled) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.hourglass_top_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$index giây',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: _controller.collectionSetting.value.restTime,
            onSelectedItemChanged: (value) {
              _controller.collectionSetting.update((val) {
                val!.restTime = value;
              });
            });
      },
      title: 'Thời gian nghỉ'.tr,
      trailing: '${_controller.collectionSetting.value.restTime} giây'.tr,
    );
  }

// check check!!
  Widget _buildRestFrequencyProperty(context, maxHeight, enabled) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.air_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'sau $index bài', // chỗ này có phải check thêm điều kiện count danh sách bài tập trong collection?
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: _controller.collectionSetting.value.restFrequency,
            onSelectedItemChanged: (value) {
              _controller.collectionSetting.update((val) {
                val!.restFrequency = value;
              });
            });
      },
      title: 'Lượt nghỉ'.tr,
      trailing:
          'sau ${_controller.collectionSetting.value.restFrequency} bài'.tr,
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

  _showSelection(context,
      {required double maxHeight,
      required Widget? Function(BuildContext, int) itemBuilder,
      required Function(int)? onSelectedItemChanged,
      required int initialValue}) async {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: maxHeight * 0.32,
          child: CupertinoPicker.builder(
            onSelectedItemChanged: onSelectedItemChanged,
            backgroundColor: Colors.white,
            itemExtent: 48,
            scrollController:
                FixedExtentScrollController(initialItem: initialValue),
            itemBuilder: itemBuilder,
          ),
        );
      },
    );
  }
}
