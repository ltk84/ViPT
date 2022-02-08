import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/providers/workout_category_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';

class WorkoutController extends GetxController {
  late List<Workout> currentWorkoutList;
  late List<WorkoutCategory> workoutCategories;
  Map<String, int> cateListAndNumWorkout = {};
  @override
  void onInit() async {
    super.onInit();
    workoutCategories = DataService.instance.workoutCateList
        .where((element) => element.parentCategoryID == null)
        .toList();
    initCateListAndNumWorkout();
  }

  void initCateListAndNumWorkout() async {
    for (var item in DataService.instance.workoutCateList) {
      String cateID = item.id as String;
      cateListAndNumWorkout[cateID] = countNumberOfWorkoutBaseOnCateID(item);
    }
  }

  int countNumberOfWorkoutBaseOnCateID(WorkoutCategory cate) {
    int num = 0;
    List<String> childCateID = [];

    bool isRootCate = cate.isRootCategory();

    if (isRootCate) {
      for (var cate in DataService.instance.workoutCateList) {
        if (cate.parentCategoryID == cate.id) {
          childCateID.add(cate.id ?? '');
        }
      }

      if (childCateID.isNotEmpty) {
        for (var cate in childCateID) {
          for (var wk in DataService.instance.workoutList) {
            num = num + (wk.categoryIDs.contains(cate) ? 1 : 0);
          }
        }
      } else {
        for (var wk in DataService.instance.workoutList) {
          num = num + (wk.categoryIDs.contains(cate.id) ? 1 : 0);
        }
      }
    } else {
      for (var wk in DataService.instance.workoutList) {
        num = num + (wk.categoryIDs.contains(cate.id) ? 1 : 0);
      }
    }

    return num;
  }

  void loadWorkoutListBaseOnCategory(String categoryID) {
    currentWorkoutList = DataService.instance.workoutList
        .where((workout) => workout.categoryIDs.contains(categoryID))
        .toList();
  }

  void loadChildCategoriesBaseOnParentCategory(String categoryID) {
    workoutCategories = DataService.instance.workoutCateList
        .where((element) => element.parentCategoryID == categoryID)
        .toList();
  }
}
