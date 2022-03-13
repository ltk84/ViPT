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
import 'package:vipt/app/routes/pages.dart';

class EditableExerciseListWidget extends StatelessWidget {
  final AddWorkoutCollectionController controller;
  const EditableExerciseListWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            controller.assignForSelectValueList();
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
            controller.removeAllWorkoutFromCollection();
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
            children: controller.workoutIDs.map((e) {
              final workout = DataService.instance.workoutList
                  .firstWhere((element) => element.id == e);
              return ExerciseInCollectionTile(
                asset: workout.thumbnail,
                title: workout.name,
                onPressed: () {
                  Get.toNamed(Routes.exerciseDetail, arguments: workout);
                },
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
