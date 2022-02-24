import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/services/cloud_storage_service.dart';
import 'package:vipt/app/modules/profile/widgets/custom_tile.dart';
import 'package:vipt/app/modules/workout/workout_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class ExerciseListScreen extends StatelessWidget {
  ExerciseListScreen({Key? key}) : super(key: key);

  final _controller = Get.find<WorkoutController>();
  final Category cate = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            cate.name,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (_, index) {
            var workout = _controller.workouts[index];

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
                          child: CustomTile(
                            level: 2,
                            asset: '',
                            onPressed: () {},
                            title: '',
                          )),
                    );
                  }
                  return CustomTile(
                    level: 2,
                    asset: snapshot.data as String? ?? '',
                    onPressed: () {
                      Get.toNamed(Routes.exerciseDetail, arguments: workout);
                    },
                    title: workout.name,
                  );
                });
          },
          separatorBuilder: (_, index) => const Divider(
                indent: 24,
              ),
          itemCount: _controller.workouts.length),
    );
  }
}
