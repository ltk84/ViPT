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
import 'package:vipt/app/global_widgets/app_bar_icon_button.dart';
import 'package:vipt/app/modules/workout_collection/widgets/collection_setting_widget.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
// ignore: unused_import
import 'package:vipt/app/modules/workout_collection/widgets/property_tile.dart';
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
            onLeaveScreen();
            await Get.toNamed(Routes.previewExerciseList);
            init();
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
                      CollectionSettingWidget(
                        maxHeight: constraints.maxHeight,
                        controller: _controller,
                        enabled: _controller.workoutList.isNotEmpty,
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
            '${_controller.displayTime}'.tr,
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
