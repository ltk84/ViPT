import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutController extends GetxController {
  late List<Workout> workouts;
  late List<Category> workoutCategories;
  late Map<String, int> cateListAndNumWorkout;

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
