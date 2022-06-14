import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/global_widgets/editable_exercise_list_widget.dart';
import 'package:vipt/app/global_widgets/editable_intro_collection_widget.dart';
import 'package:vipt/app/modules/workout_collection/add_workout_collection_controller.dart';

class EditWorkoutCollectionScreen extends StatelessWidget {
  EditWorkoutCollectionScreen({Key? key}) : super(key: key);

  final _controller = Get.find<AddWorkoutCollectionController>();

  @override
  Widget build(BuildContext context) {
    _controller.beforeEdit();
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
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
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
              _controller.editWorkoutCollection();
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
              EditableIntroCollectionWidget(
                  titleTextController: _controller.titleTextController,
                  descriptionTextController:
                      _controller.descriptionTextController),
              const SizedBox(
                height: 16,
              ),
              EditableExerciseListWidget(controller: _controller),
            ],
          );
        }),
      ),
    );
  }

  // Widget _buildExerciseList(context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text('Danh sách bài tập'.tr,
  //           style: Theme.of(context).textTheme.headline3),
  //       const SizedBox(
  //         height: 4,
  //       ),
  //       ListTile(
  //         onTap: () {
  //           _controller.assignForSelectValueList();
  //           Get.bottomSheet(
  //             Container(
  //               margin: const EdgeInsets.only(top: 48),
  //               child: ClipRRect(
  //                   borderRadius: const BorderRadius.only(
  //                     topLeft: Radius.circular(10.0),
  //                     topRight: Radius.circular(10.0),
  //                   ),
  //                   child: AddExerciseToCollectionScreen()),
  //             ),
  //             isScrollControlled: true,
  //           );
  //         },
  //         horizontalTitleGap: 5,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(5),
  //           ),
  //         ),
  //         leading: Icon(
  //           Icons.add,
  //           color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
  //         ),
  //         title: Text(
  //           'Thêm bài tập'.tr,
  //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                 color:
  //                     AppColor.textColor.withOpacity(AppColor.subTextOpacity),
  //               ),
  //         ),
  //       ),
  //       Divider(
  //         color: AppColor.textFieldUnderlineColor,
  //         height: 0,
  //       ),
  //       ListTile(
  //         onTap: () {
  //           _controller.removeAllWorkoutFromCollection();
  //         },
  //         horizontalTitleGap: 5,
  //         shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(5),
  //           ),
  //         ),
  //         leading: Icon(
  //           Icons.delete_sweep_rounded,
  //           color: AppColor.textColor.withOpacity(AppColor.subTextOpacity),
  //         ),
  //         title: Text(
  //           'Xóa hết'.tr,
  //           style: Theme.of(context).textTheme.bodyText1!.copyWith(
  //                 color:
  //                     AppColor.textColor.withOpacity(AppColor.subTextOpacity),
  //               ),
  //         ),
  //       ),
  //       Divider(
  //         color: AppColor.textFieldUnderlineColor,
  //         height: 0,
  //       ),
  //       GetBuilder<AddWorkoutCollectionController>(
  //         builder: (_) => Column(
  //           children: _controller.workoutIDs.map((e) {
  //             final workout = DataService.instance.workoutList
  //                 .firstWhere((element) => element.id == e);
  //             return ExerciseInCollectionTile(
  //               asset: workout.thumbnail,
  //               title: workout.name,
  //               onPressed: () {
  //                 Get.toNamed(Routes.exerciseDetail, arguments: workout);
  //               },
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
