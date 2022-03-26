import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/component.dart';

class MealCategory extends Category implements Component {
  List<Component> components = [];

  MealCategory() : super('', name: '', asset: '', parentCategoryID: '');

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
