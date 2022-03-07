import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/services/cloud_storage_service.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/workout_collection/add_workout_collection_controller.dart';
import 'package:vipt/app/modules/workout_collection/screens/add_exercise_to_collection_screen.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/widgets/text_field_widget.dart';
import 'package:vipt/app/routes/pages.dart';

class AddWorkoutCollectionScreen extends StatelessWidget {
  AddWorkoutCollectionScreen({Key? key}) : super(key: key);

  final _controller = Get.find<AddWorkoutCollectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.close_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            _controller.resetScreen();
          },
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
            onPressed: () {
              _controller.addWorkoutCollection();
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
                height: 16,
              ),
              _buildExerciseList(context),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildIntro(context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          child: TextFieldWidget(
            textEditingController: _controller.titleTextController,
            hint: 'Nhập tên bộ luyện tập',
            textStyle: Theme.of(context).textTheme.headline2,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: TextFieldWidget(
            textEditingController: _controller.descriptionTextController,
            hint: 'Nhập mô tả',
            textStyle: Theme.of(context).textTheme.subtitle2,
            underline: false,
          ),
        ),
      ],
    );
  }

  Widget _buildExerciseList(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Danh sách bài tập'.tr,
            style: Theme.of(context).textTheme.headline3),
        const SizedBox(
          height: 4,
        ),
        ListTile(
          onTap: () {
            _controller.assignForSelectValueList();
            Get.bottomSheet(
              Container(
                margin: const EdgeInsets.only(top: 48),
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: AddExerciseToCollectionScreen()),
              ),
              isScrollControlled: true,
            );
          },
          horizontalTitleGap: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          leading: Icon(
            Icons.add,
            color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
          ),
          title: Text(
            'Thêm bài tập'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
        ),
        Divider(
          color: AppColor.textFieldUnderlineColor,
          height: 0,
        ),
        ListTile(
          onTap: () {
            _controller.removeAllWorkoutFromCollection();
          },
          horizontalTitleGap: 5,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          leading: Icon(
            Icons.delete_sweep_rounded,
            color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
          ),
          title: Text(
            'Xóa hết'.tr,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color:
                      AppColor.textColor.withOpacity(AppColor.subTextOpacity),
                ),
          ),
        ),
        Divider(
          color: AppColor.textFieldUnderlineColor,
          height: 0,
        ),
        GetBuilder<AddWorkoutCollectionController>(
          builder: (_) => Column(
            children: _controller.workoutIDs.map((e) {
              final workout = DataService.instance.workoutList
                  .firstWhere((element) => element.id == e);
              return FutureBuilder(
                  future: CloudStorageService.instance.storage
                      .ref()
                      .child(AppValue.workoutsStorageCollectionPath)
                      .child(AppValue.workoutsThumbStorageCollectionPath)
                      .child(workout.thumbnail)
                      .getDownloadURL(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: 200.0,
                        height: 100.0,
                        child: Shimmer.fromColors(
                          baseColor: AppColor.textColor,
                          highlightColor: Theme.of(context).backgroundColor,
                          child: ExerciseInCollectionTile(
                            asset: '',
                            title: '',
                            description: '',
                            onPressed: () {},
                          ),
                        ),
                      );
                    }
                    return ExerciseInCollectionTile(
                      asset: snapshot.data as String? ?? '',
                      title: workout.name,
                      onPressed: () {
                        Get.toNamed(Routes.exerciseDetail, arguments: workout);
                      },
                    );
                  });
            }).toList(),
          ),
        ),
      ],
    );
  }
}
