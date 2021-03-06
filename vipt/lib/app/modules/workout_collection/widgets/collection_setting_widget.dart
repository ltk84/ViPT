import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/modules/workout_collection/widgets/property_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class CollectionSettingWidget extends StatelessWidget {
  final bool enabled;
  final WorkoutCollectionController controller;
  final bool showShuffleTile;
  const CollectionSettingWidget(
      {Key? key,
      this.enabled = true,
      this.showShuffleTile = false,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _maxHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Obx(
          () => _buildRoundProperty(context, _maxHeight),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => _buildNumOfWorkoutPerRoundProperty(context, _maxHeight),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => _buildWarmUpProperty(context),
        ),
        const SizedBox(
          height: 12,
        ),
        if (showShuffleTile)
          Obx(
            () => _buildShuffleProperty(context),
          ),
        if (showShuffleTile)
          const SizedBox(
            height: 12,
          ),
        Obx(
          () => _buildExerciseTimeProperty(context, _maxHeight),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => _buildTransitionTimeProperty(context, _maxHeight),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => _buildRestTimeProperty(context, _maxHeight),
        ),
        const SizedBox(
          height: 12,
        ),
        Obx(
          () => _buildRestFrequencyProperty(context, _maxHeight),
        ),
      ],
    );
  }

  Widget _buildRoundProperty(context, _maxHeight) {
    return PropertyTile(
      enabled: enabled,
      onTap: () {
        _showSelection(
          context,
          maxHeight: _maxHeight,
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
          initialValue: controller.collectionSetting.value.round,
          onSelectedItemChanged: (value) {
            controller.collectionSetting.update((val) {
              val!.round = value;
            });
          },
        );
      },
      title: 'S??? v??ng'.tr,
      trailing: controller.collectionSetting.value.round.toString(),
      iconData: Icons.repeat_rounded,
    );
  }

  Widget _buildNumOfWorkoutPerRoundProperty(context, _maxHeight) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.looks_3_outlined,
      onTap: () {
        _showSelection(
          context,
          maxHeight: _maxHeight,
          itemBuilder: (context, index) {
            if (index >= 0 && index <= controller.maxWorkout.value) {
              return Container(
                alignment: Alignment.center,
                child: Text(
                  index.toString(),
                  style: Theme.of(context).textTheme.headline4,
                ),
              );
            }
          },
          initialValue: controller.collectionSetting.value.numOfWorkoutPerRound,
          onSelectedItemChanged: (value) {
            controller.collectionSetting.update((val) {
              val!.numOfWorkoutPerRound = value;
            });
            controller.generateRandomList();
          },
        );
      },
      title: 'S??? b??i t???p m???i v??ng'.tr,
      trailing:
          controller.collectionSetting.value.numOfWorkoutPerRound.toString(),
    );
  }

  Widget _buildWarmUpProperty(context) {
    Color disabledColor =
        AppColor.textColor.withOpacity(AppColor.disabledTextOpacity);

    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: SwitchListTile(
        activeColor: Theme.of(context).primaryColor,
        onChanged: enabled
            ? (bool value) {
                controller.collectionSetting.update((val) {
                  val!.isStartWithWarmUp = value;
                });
              }
            : null,
        value: controller.collectionSetting.value.isStartWithWarmUp,
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
          'B???t ?????u v???i kh???i ?????ng'.tr,
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

  Widget _buildShuffleProperty(context) {
    Color disabledColor =
        AppColor.textColor.withOpacity(AppColor.disabledTextOpacity);

    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: SwitchListTile(
        activeColor: Theme.of(context).primaryColor,
        onChanged: enabled
            ? (bool value) {
                controller.collectionSetting.update((val) {
                  val!.isShuffle = value;
                });
              }
            : null,
        value: controller.collectionSetting.value.isShuffle,
        tileColor: AppColor.listTileButtonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        secondary: Icon(
          Icons.shuffle_rounded,
          color: enabled ? AppColor.textColor : disabledColor,
        ),
        title: Text(
          'Tr???n ng???u nhi??n'.tr,
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

  Widget _buildExerciseTimeProperty(context, _maxHeight) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.timelapse_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: _maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$index gi??y',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: controller.collectionSetting.value.exerciseTime,
            onSelectedItemChanged: (value) {
              controller.collectionSetting.update((val) {
                val!.exerciseTime = value;
              });
            });
      },
      title: 'Th???i gian m???i b??i'.tr,
      trailing: '${controller.collectionSetting.value.exerciseTime} gi??y'.tr,
    );
  }

  Widget _buildTransitionTimeProperty(context, _maxHeight) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.sync_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: _maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$index gi??y',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: controller.collectionSetting.value.transitionTime,
            onSelectedItemChanged: (value) {
              controller.collectionSetting.update((val) {
                val!.transitionTime = value;
              });
            });
      },
      title: 'Th???i gian chuy???n'.tr,
      trailing: '${controller.collectionSetting.value.transitionTime} gi??y'.tr,
    );
  }

  Widget _buildRestTimeProperty(context, _maxHeight) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.hourglass_top_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: _maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    '$index gi??y',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: controller.collectionSetting.value.restTime,
            onSelectedItemChanged: (value) {
              controller.collectionSetting.update((val) {
                val!.restTime = value;
              });
            });
      },
      title: 'Th???i gian ngh???'.tr,
      trailing: '${controller.collectionSetting.value.restTime} gi??y'.tr,
    );
  }

// check check!!
  Widget _buildRestFrequencyProperty(context, _maxHeight) {
    return PropertyTile(
      enabled: enabled,
      iconData: Icons.air_rounded,
      onTap: () {
        _showSelection(context,
            maxHeight: _maxHeight,
            itemBuilder: (context, index) {
              if (index > 0) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'sau $index b??i', // ch??? n??y c?? ph???i check th??m ??i???u ki???n count danh s??ch b??i t???p trong collection?
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              }
            },
            initialValue: controller.collectionSetting.value.restFrequency,
            onSelectedItemChanged: (value) {
              controller.collectionSetting.update((val) {
                val!.restFrequency = value;
              });
            });
      },
      title: 'L?????t ngh???'.tr,
      trailing:
          'sau ${controller.collectionSetting.value.restFrequency} b??i'.tr,
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
