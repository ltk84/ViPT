import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/core/values/values.dart';
import 'package:vipt/app/data/services/cloud_storage_service.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/setup_info/widgets/multiple_choice_card.dart';
import 'package:vipt/app/modules/workout_collection/add_workout_collection_controller.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/widgets/search_field_widget.dart';

class AddExerciseToCollectionScreen extends StatelessWidget {
  AddExerciseToCollectionScreen({Key? key}) : super(key: key);

  final _controller = Get.find<AddWorkoutCollectionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.close_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Thêm bài tập'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
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
              _controller.onSaveAfterAddExercise();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            child: SearchFieldWidget(
                controller: _controller.searchTextController,
                textStyle: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontSize: 16)),
          ),
          Divider(
            height: 0,
            color: AppColor.textFieldUnderlineColor,
          ),
          GetBuilder<AddWorkoutCollectionController>(
            builder: (_) => Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: _controller.searchTextController.text.isNotEmpty
                    ? _buildSearchResultListView(context, _controller)
                    : _buildInitialListView(context, _controller),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSearchResultListView(
    context, AddWorkoutCollectionController _controller) {
  return ListView(
    physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        alignment: Alignment.center,
        child: Obx(
          () => Text(
            'Đã chọn ${_controller.selectValueList.length} bài tập',
            style: Theme.of(Get.context!).textTheme.subtitle1,
          ),
        ),
      ),
      ResponsiveGridRow(
        children: _controller.searchResult.map((workout) {
          return ResponsiveGridCol(
            xs: 12,
            child: FutureBuilder(
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
                        baseColor: AppColor.textColor
                            .withOpacity(AppColor.subTextOpacity * 0.5),
                        highlightColor: Theme.of(context)
                            .backgroundColor
                            .withOpacity(AppColor.subTextOpacity * 0.5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: MultipleChoiceCard(
                            title: '',
                            subtitle: null,
                            asset: '',
                            isSelected: false,
                            onSelected: () {},
                          ),
                        ),
                      ),
                    );
                  }
                  return Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: MultipleChoiceCard(
                        title: workout.name,
                        subtitle: null,
                        asset: snapshot.data as String? ?? '',
                        isSelected:
                            _controller.selectValueList.contains(workout.id),
                        onSelected: () {
                          _controller.handleSelect(workout.id ?? '');
                        },
                      ),
                    ),
                  );
                }),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildInitialListView(context, _controller) {
  return ListView(
    physics:
        const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
    children: [
      Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        alignment: Alignment.center,
        child: Obx(
          () => Text(
            'Đã chọn ${_controller.selectValueList.length} bài tập',
            style: Theme.of(Get.context!).textTheme.subtitle1,
          ),
        ),
      ),
      ResponsiveGridRow(
        children: DataService.instance.workoutList.map((workout) {
          return ResponsiveGridCol(
            xs: 12,
            child: FutureBuilder(
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
                        baseColor: AppColor.textColor
                            .withOpacity(AppColor.subTextOpacity * 0.5),
                        highlightColor: Theme.of(context)
                            .backgroundColor
                            .withOpacity(AppColor.subTextOpacity * 0.5),
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          child: MultipleChoiceCard(
                            title: '',
                            subtitle: null,
                            asset: '',
                            isSelected: false,
                            onSelected: () {},
                          ),
                        ),
                      ),
                    );
                  }
                  return Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      child: MultipleChoiceCard(
                        title: workout.name,
                        subtitle: null,
                        asset: snapshot.data as String? ?? '',
                        isSelected:
                            _controller.selectValueList.contains(workout.id),
                        onSelected: () {
                          _controller.handleSelect(workout.id ?? '');
                        },
                      ),
                    ),
                  );
                }),
          );
        }).toList(),
      ),
    ],
  );
}
