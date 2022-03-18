import 'package:get/get.dart';
import 'package:vipt/app/data/models/component.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutController extends GetxController {
  late List<Workout> workouts;
  late List<Category> workoutCategories;
  late Map<String, int> cateListAndNumWorkout;
  late WorkoutCategory workoutTree;

  @override
  void onInit() async {
    super.onInit();
    initWorkoutCategories();
    initWorkoutList();
    initCateListAndNumWorkout();
    initWorkoutTree();
  }

  // void initWorkoutTree() {
  //   workoutTree = WorkoutCategory();

  //   List<WorkoutCategory> branchList = [];

  //   for (var item in DataService.instance.workoutCateList) {
  //     if (item.isRootCategory()) {
  //       branchList.add(WorkoutCategory.fromCategory(item));
  //     }
  //   }

  //   for (var item in branchList) {
  //     for (var cateInDS in DataService.instance.workoutCateList) {
  //       if (cateInDS.parentCategoryID == item.id) {
  //         item.add(WorkoutCategory.fromCategory(cateInDS));
  //       }
  //     }

  //     for (var wk in DataService.instance.workoutList) {
  //       if (wk.categoryIDs.contains(item.id)) {
  //         item.add(wk);
  //       }
  //     }
  //   }

  //   for (var item in branchList) {
  //     workoutTree.add(item);
  //   }

  //   print(workoutTree.countLeaf());
  // }

  void initWorkoutTree() {
    Map map = {
      for (var e in DataService.instance.workoutCateList)
        e.id: WorkoutCategory.fromCategory(e)
    };

    workoutTree = WorkoutCategory();

    for (var item in DataService.instance.workoutCateList) {
      if (item.isRootCategory()) {
        workoutTree.add(map[item.id]);
      } else {
        WorkoutCategory parentCate = map[item.parentCategoryID];
        parentCate.add(WorkoutCategory.fromCategory(item));
      }
    }

    for (var item in DataService.instance.workoutList) {
      for (var cateID in item.categoryIDs) {
        WorkoutCategory? wkCate =
            workoutTree.searchWorkoutCategory(cateID, workoutTree.list);
        wkCate!.add(item);
      }
    }
  }

  void initWorkoutList() {
    workouts = [];
  }

  void initWorkoutCategories() {
    workoutCategories = DataService.instance.workoutCateList
        .where((element) => element.parentCategoryID == null)
        .toList();
  }

  void initCateListAndNumWorkout() {
    cateListAndNumWorkout = DataService.instance.cateListAndNumWorkout;
  }

  void loadWorkoutListBaseOnCategory(Category cate) {
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
