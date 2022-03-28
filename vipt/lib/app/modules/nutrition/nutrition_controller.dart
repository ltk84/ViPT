import 'package:get/get.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/component.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_category.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class NutritionController extends GetxController {
  List<Meal> meals = [];
  List<MealCategory> mealCategories = [];
  late MealCategory mealTree;

  @override
  void onInit() {
    super.onInit();
    initMealTree();
    initMealCategories();
  }

  // khởi tạo danh sách hiển thị categories
  void initMealCategories() {
    mealCategories = mealTree.getList();
  }

  // init meal tree
  void initMealTree() {
    // map giữ các meal category
    Map map = {
      for (var e in DataService.instance.mealCategoryList)
        e.id: MealCategory.fromCategory(e)
    };

    // khởi tạo gốc cây
    mealTree = MealCategory();

    // thiết lập các node của cây là các meal category
    for (var item in DataService.instance.mealCategoryList) {
      if (item.isRootCategory()) {
        mealTree.add(map[item.id]);
      } else {
        MealCategory parentCate = map[item.parentCategoryID];
        parentCate.add(MealCategory.fromCategory(item));
      }
    }

    // thêm các meal vào các meal category phù hợp
    for (var item in DataService.instance.mealList) {
      for (var cateID in item.categoryIDs) {
        MealCategory? wkCate =
            mealTree.searchComponent(cateID, mealTree.components);
        wkCate!.add(item);
      }
    }
  }

  void loadMealsBaseOnCategory(Category cate) {
    meals =
        mealTree.searchComponent(cate.id ?? '', mealTree.components)!.getList();
    Get.toNamed(Routes.dishList, arguments: cate);
  }

  void loadChildCategoriesBaseOnParentCategory(String categoryID) {
    mealCategories =
        mealTree.searchComponent(categoryID, mealTree.components)!.getList();
    Get.toNamed(Routes.dishCategory, preventDuplicates: false);
  }

  void loadContent(Component comp) {
    var cate = comp as MealCategory;
    if (cate.hasChildIsCate()) {
      loadChildCategoriesBaseOnParentCategory(cate.id ?? '');
    } else {
      loadMealsBaseOnCategory(cate);
    }
  }
}
