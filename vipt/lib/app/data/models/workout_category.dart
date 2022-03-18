import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/component.dart';
import 'package:vipt/app/data/models/workout.dart';

class WorkoutCategory extends Category implements Component {
  List<Component> list = [];

  WorkoutCategory() : super('', name: '', asset: '', parentCategoryID: '');

  WorkoutCategory.fromCategory(Category category)
      : super(category.id,
            name: category.name,
            asset: category.asset,
            parentCategoryID: category.parentCategoryID);

  void add(Component cate) {
    list.add(cate);
  }

  WorkoutCategory? searchWorkoutCategory(String id, List<Component> list) {
    for (var item in list) {
      if (item is WorkoutCategory) {
        if (item.id == id) {
          return item;
        }

        if (item.list.isNotEmpty) {
          WorkoutCategory? result = searchWorkoutCategory(id, item.list);
          if (result != null) return result;
        }
      }
    }
  }

  @override
  int countLeaf() {
    int sum = 0;
    for (var item in list) {
      sum += item.countLeaf();
    }
    return sum;
  }
}
