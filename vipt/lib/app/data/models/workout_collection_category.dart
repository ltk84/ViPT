import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/component.dart';
import 'package:vipt/app/data/models/workout_collection.dart';

class WorkoutCollectionCategory extends Category implements Component {
  List<Component> components = [];

  WorkoutCollectionCategory()
      : super('', name: '', asset: '', parentCategoryID: '');

  WorkoutCollectionCategory.fromCategory(Category category)
      : super(category.id,
            name: category.name,
            asset: category.asset,
            parentCategoryID: category.parentCategoryID);

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

  void add(Component cate) {
    components.add(cate);
  }

  dynamic getList() {
    if (components.isEmpty) {
      return [];
    }

    if (components[0].isComposite()) {
      return List<WorkoutCollectionCategory>.from(components);
    }

    return List<WorkoutCollection>.from(components);
  }

  WorkoutCollectionCategory? searchComponent(String id, List<Component> list) {
    for (var item in list) {
      if (item is WorkoutCollectionCategory) {
        if (item.id == id) {
          return item;
        }

        if (item.components.isNotEmpty) {
          WorkoutCollectionCategory? result =
              searchComponent(id, item.components);
          if (result != null) return result;
        }
      }
    }
  }
}
