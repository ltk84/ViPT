import 'package:flutter/material.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';

class CollectionTabHolder extends StatefulWidget {
  const CollectionTabHolder({Key? key}) : super(key: key);

  @override
  State<CollectionTabHolder> createState() => _CollectionTabHolderState();
}

class _CollectionTabHolderState extends State<CollectionTabHolder>
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
            labelStyle: Theme.of(context).textTheme.caption,
            tabs: const [
              Tab(
                text: 'Mặc định',
              ),
              Tab(
                text: 'Cá nhân',
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
                ..._buildCollectionList([
                  WorkoutCollection('1',
                      title: 'Alo',
                      description: 'category',
                      asset: '',
                      generatorIDs: [],
                      categoryIDs: []),
                ]),
              ],
            );
          } else {
            return Column(
              children: [
                ..._buildCollectionList([
                  WorkoutCollection('1',
                      title: 'Alo 2',
                      description: 'category',
                      asset: '',
                      generatorIDs: [],
                      categoryIDs: []),
                ]),
              ],
            );
          }
        }),
      ],
    );
  }

  _buildCollectionList(List<WorkoutCollection> workoutCollectionList) {
    return workoutCollectionList
        .map((collection) => Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ExerciseInCollectionTile(
                  asset: collection.asset,
                  title: collection.title,
                  description: 'Category name',
                  onPressed: () {}),
            ))
        .toList();
  }
}
