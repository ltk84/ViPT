import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/component.dart';
import 'package:vipt/app/data/models/meal.dart';

class MealCategory extends Category implements Component {
  List<Component> components = [];

  MealCategory() : super('', name: '', asset: '', parentCategoryID: '');

  MealCategory.fromCategory(Category category)
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
      return List<MealCategory>.from(components);
    }

    return List<Meal>.from(components);
  }

  MealCategory? searchComponent(String id, List<Component> list) {
    for (var item in list) {
      if (item is MealCategory) {
        if (item.id == id) {
          return item;
        }

        if (item.components.isNotEmpty) {
          MealCategory? result = searchComponent(id, item.components);
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
