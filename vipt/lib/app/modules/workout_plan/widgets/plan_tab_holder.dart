import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/routes/pages.dart';

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
  late TabController _controller;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: TabBar(
            controller: _controller,
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
                      final _collectionController =
                          Get.put(WorkoutCollectionController());
                      _collectionController.onSelectDefaultCollection(col);
                      await Get.toNamed(Routes.workoutCollectionDetail);
                      Get.delete<WorkoutCollectionController>();
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
