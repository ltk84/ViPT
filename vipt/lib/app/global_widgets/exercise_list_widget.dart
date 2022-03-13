import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class ExerciseListWidget extends StatelessWidget {
  final List<Workout> workoutList;
  final String displayExerciseTime;
  const ExerciseListWidget(
      {Key? key, required this.workoutList, required this.displayExerciseTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ...workoutList.map(
            (workout) => ExerciseInCollectionTile(
              asset: workout.thumbnail,
              title: workout.name,
              description: displayExerciseTime,
              onPressed: () {
                Get.toNamed(Routes.exerciseDetail, arguments: workout);
              },
            ),
          ),
        ],
      ),
    );
  }
}
