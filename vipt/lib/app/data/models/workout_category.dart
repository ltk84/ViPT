import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/component.dart';
import 'package:vipt/app/data/models/workout.dart';

class WorkoutCategory extends Category implements Component {
  List<Component> components = [];

  WorkoutCategory() : super('', name: '', asset: '', parentCategoryID: '');

  WorkoutCategory.fromCategory(Category category)
      : super(category.id,
            name: category.name,
            asset: category.asset,
            parentCategoryID: category.parentCategoryID);

  void add(Component cate) {
    components.add(cate);
  }

  getList() {
    if (components.isEmpty) {
      return [];
    }

    if (components[0].isComposite()) {
      return List<WorkoutCategory>.from(components);
    }

    return List<Workout>.from(components);
  }

  WorkoutCategory? searchComponent(String id, List<Component> list) {
    for (var item in list) {
      if (item is WorkoutCategory) {
        if (item.id == id) {
          return item;
        }

        if (item.components.isNotEmpty) {
          WorkoutCategory? result = searchComponent(id, item.components);
          if (result != null) return result;
        }
      }
    }
  }

  @override
  int countLeaf() {
    int sum = 0;
    for (var item in components) {
      sum += item.countLeaf();
    }
    return sum;
  }

  @override
  bool isComposite() {
    return true;
  }
}
