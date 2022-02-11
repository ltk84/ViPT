import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/workout_equipment.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/providers/workout_category_provider.dart';
import 'package:vipt/app/data/providers/workout_equipment_provider.dart';
import 'package:vipt/app/data/providers/workout_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';

class DataService {
  DataService._privateConstructor();

  static final DataService instance = DataService._privateConstructor();
  static late ViPTUser currentUser;
  static late List<Workout> _workoutList;
  static late List<Category> _workoutCateList;
  static late Map<String, int> _cateListAndNumWorkout;
  static List<WorkoutEquipment> workoutEquipList = [];

  final _userProvider = UserProvider();
  final _workoutProvider = WorkoutProvider();
  final _workoutCategoryProvider = WorkoutCategoryProvider();
  final _workoutEquipmentProvider = WorkoutEquipmentProvider();

  List<Workout> get workoutList => [..._workoutList];
  List<Category> get workoutCateList => [..._workoutCateList];
  Map<String, int> get cateListAndNumWorkout => _cateListAndNumWorkout;

  Future<ViPTUser> createUser(ViPTUser user) async {
    currentUser = await _userProvider.add(user);
    return currentUser;
  }

  Future<void> loadUserData() async {
    currentUser =
        await _userProvider.fetch(AuthService.instance.currentUser!.uid);
  }

  loadWorkoutList() async {
    _workoutList = await _workoutProvider.fetchAll();
  }

  loadWorkoutCategory() async {
    _workoutCateList = await _workoutCategoryProvider.fetchAll();
  }

  loadWorkoutEquipment() async {
    workoutEquipList = await _workoutEquipmentProvider.fetchAll();
  }

  bool checkIfWorkoutCategoryHasChild(Category cate) {
    for (var item in workoutCateList) {
      if (item.parentCategoryID == cate.id) return true;
    }
    return false;
  }

  initCateListAndNumWorkout() async {
    _cateListAndNumWorkout = {};
    for (var item in DataService.instance.workoutCateList) {
      String cateID = item.id as String;
      _cateListAndNumWorkout[cateID] = countNumberOfWorkoutBaseOnCateID(item);
    }
  }

  int countNumberOfWorkoutBaseOnCateID(Category cate) {
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
}
