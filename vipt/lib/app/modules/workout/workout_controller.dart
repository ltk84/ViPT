import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_category.dart';
import 'package:vipt/app/data/services/data_service.dart';

class WorkoutController extends GetxController {
  late List<Workout> currentWorkoutList;
  late List<WorkoutCategory> workoutCateList;
  @override
  void onInit() {
    super.onInit();
    DataService.instance.loadWorkoutCategory();
    DataService.instance.loadWorkoutList();

    workoutCateList = DataService.workoutCateList;
  }

  void loadWorkoutListBaseOnCategory(String categoryID) {
    currentWorkoutList = DataService.workoutList
        .where((workout) => workout.categoryIDs.contains(categoryID))
        .toList();
  }
}
