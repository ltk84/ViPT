import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutController extends GetxController {
  late List<Workout> workouts;
  late List<WorkoutCategory> workoutCategories;
  Map<String, int> cateListAndNumWorkout = {};

  @override
  void onInit() async {
    super.onInit();
    initWorkoutCategories();
    initWorkoutList();
    initCateListAndNumWorkout();
  }

  void initWorkoutList() {
    workouts = [];
  }

  void initWorkoutCategories() {
    workoutCategories = DataService.instance.workoutCateList
        .where((element) => element.parentCategoryID == null)
        .toList();
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
      for (var c in DataService.instance.workoutCateList) {
        if (c.parentCategoryID == cate.id) {
          childCateID.add(c.id ?? '');
        }
      }

      if (childCateID.isNotEmpty) {
        for (var child in childCateID) {
          for (var wk in DataService.instance.workoutList) {
            num = num + (wk.categoryIDs.contains(child) ? 1 : 0);
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

  void loadWorkoutListBaseOnCategory(WorkoutCategory cate) {
    workouts = DataService.instance.workoutList
        .where((workout) => workout.categoryIDs.contains(cate.id))
        .toList();
    Get.toNamed(Routes.exerciseList, arguments: cate);
  }

  void loadChildCategoriesBaseOnParentCategory(String categoryID) {
    workoutCategories = DataService.instance.workoutCateList
        .where((element) => element.parentCategoryID == categoryID)
        .toList();
    Get.toNamed(Routes.workoutCategory, preventDuplicates: false);
  }
}
