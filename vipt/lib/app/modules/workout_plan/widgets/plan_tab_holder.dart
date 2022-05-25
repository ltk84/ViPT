import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

import '../workout_plan_controller.dart';

class PlanTabHolder extends StatefulWidget {
  const PlanTabHolder(
      {required this.firstCollection, required this.secondCollection, Key? key})
      : super(key: key);

  final List<WorkoutCollection> firstCollection;
  final List<WorkoutCollection> secondCollection;

  @override
  State<PlanTabHolder> createState() => _PlanTabHolderState();
}

class _PlanTabHolderState extends State<PlanTabHolder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final _controller = Get.find<WorkoutPlanController>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            labelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            tabs: const [
              Tab(
                text: 'Luyện tập',
              ),
              Tab(
                text: 'Ăn uống',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Builder(builder: (_) {
          if (_selectedTabIndex == 0) {
            return Column(
              children: [
                ..._buildCollectionList(
                    workoutCollectionList: widget.firstCollection,
                    elementOnPress: (col) async {
                      await _handleSelectExercise(col);
                    }),
              ],
            );
          } else {
            return Column(
              children: [
                ..._buildCollectionList(
                    workoutCollectionList: widget.secondCollection,
                    elementOnPress: (col) async {
                      final _collectionController =
                          Get.put(WorkoutCollectionController());
                      _collectionController.onSelectUserCollection(col);
                      await Get.toNamed(Routes.myWorkoutCollectionDetail);
                      Get.delete<WorkoutCollectionController>();
                    }),
              ],
            );
          }
        }),
      ],
    );
  }

  _handleSelectExercise(WorkoutCollection col) async {
    final _collectionController = Get.put(WorkoutCollectionController());
    _collectionController.useDefaulColSetting = false;
    CollectionSetting? colSetting =
        _controller.getCollectionSetting(col.id ?? '');
    if (colSetting != null) {
      _collectionController.collectionSetting.value =
          CollectionSetting.fromCollectionSetting(colSetting);
      _collectionController.onSelectUserCollection(col);
      await Get.toNamed(Routes.myWorkoutCollectionDetail);
      await Get.delete<WorkoutCollectionController>();
    }
    // TODO: Thông báo lỗi nếu không tìm được collection setting
    else {
      print('Khong tim duoc collection setting');
    }
  }

  _buildCollectionList(
      {required List<WorkoutCollection> workoutCollectionList,
      required Function(WorkoutCollection) elementOnPress}) {
    return workoutCollectionList.map((collection) {
      String cateList = DataService.instance.collectionCateList
          .where((item) => collection.categoryIDs.contains(item.id))
          .map((e) => e.name)
          .toString()
          .replaceAll(RegExp(r'\(|\)'), '');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ExerciseInCollectionTile(
            asset: collection.asset == ''
                ? JPGAssetString.userWorkoutCollection
                : collection.asset,
            title: collection.title,
            description: cateList,
            onPressed: () {
              elementOnPress(collection);
            }),
      );
    }).toList();
  }
}
