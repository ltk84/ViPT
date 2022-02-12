import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/models/workout_equipment.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/providers/workout_category_provider.dart';
import 'package:vipt/app/data/providers/workout_collection_category_provider.dart';
import 'package:vipt/app/data/providers/workout_collection_provider.dart';
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
  static late Map<String, int> _cateListAndNumCollection;
  static late List<Category> _collectionCateList;
  static late List<WorkoutCollection> _collectionList;
  static List<WorkoutEquipment> workoutEquipList = [];

  final _userProvider = UserProvider();
  final _workoutProvider = WorkoutProvider();
  final _workoutCategoryProvider = WorkoutCategoryProvider();
  final _collectionCategoryProvider = WorkoutCollectionCategoryProvider();
  final _collectionProvider = WorkoutCollectionProvider();
  final _workoutEquipmentProvider = WorkoutEquipmentProvider();

  List<Workout> get workoutList => [..._workoutList];
  List<Category> get workoutCateList => [..._workoutCateList];
  Map<String, int> get cateListAndNumWorkout => _cateListAndNumWorkout;
  Map<String, int> get cateListAndNumCollection => _cateListAndNumCollection;
  List<WorkoutCollection> get collectionList => [..._collectionList];
  List<Category> get collectionCateList => [..._collectionCateList];

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

  bool checkIfCollectionCategoryHasChild(Category cate) {
    for (var item in collectionCateList) {
      if (item.parentCategoryID == cate.id) return true;
    }
    return false;
  }

  initCateListAndNumWorkout() async {
    _cateListAndNumWorkout = {};
    for (var item in DataService.instance.workoutCateList) {
      String cateID = item.id as String;
      _cateListAndNumWorkout[cateID] = countNumberOfChildBaseOnCateID(
          cate: item, parentList: workoutCateList, childList: workoutList);
    }
  }

  initCateListAndNumCollection() async {
    _cateListAndNumCollection = {};
    for (var item in DataService.instance.collectionCateList) {
      String cateID = item.id as String;
      _cateListAndNumCollection[cateID] = countNumberOfChildBaseOnCateID(
          cate: item,
          parentList: collectionCateList,
          childList: collectionList);
    }
  }

  int countNumberOfChildBaseOnCateID(
      {required Category cate,
      required List<dynamic> parentList,
      required List<dynamic> childList}) {
    int num = 0;
    List<String> childCateID = [];

    bool isRootCate = cate.isRootCategory();

    if (isRootCate) {
      for (var c in parentList) {
        if (c.parentCategoryID == cate.id) {
          childCateID.add(c.id ?? '');
        }
      }

      if (childCateID.isNotEmpty) {
        for (var child in childCateID) {
          for (var wk in childList) {
            num = num + (wk.categoryIDs.contains(child) ? 1 : 0);
          }
        }
      } else {
        for (var wk in childList) {
          num = num + (wk.categoryIDs.contains(cate.id) ? 1 : 0);
        }
      }
    } else {
      for (var wk in childList) {
        num = num + (wk.categoryIDs.contains(cate.id) ? 1 : 0);
      }
    }

    return num;
  }

  loadCollectionCategoryList() async {
    _collectionCateList = await _collectionCategoryProvider.fetchAll();
  }

  loadCollectionList() async {
    _collectionList = await _collectionProvider.fetchAll();
  }
}
