import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/meal_category_provider.dart';
import 'package:vipt/app/data/providers/meal_collection_provider.dart';
import 'package:vipt/app/data/providers/meal_provider.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/providers/workout_category_provider.dart';
import 'package:vipt/app/data/providers/workout_collection_category_provider.dart';
import 'package:vipt/app/data/providers/workout_collection_provider.dart';
import 'package:vipt/app/data/providers/workout_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';

class DataService {
  DataService._privateConstructor();

  static final DataService instance = DataService._privateConstructor();
  static ViPTUser? currentUser;

  static late List<Workout> _workoutList = [];
  static late List<Category> _workoutCateList = [];
  static late List<Category> _collectionCateList = [];
  static late List<WorkoutCollection> _collectionList = [];
  static late List<WorkoutCollection> _userCollectionList = [];
  static late List<Category> _mealCategories = [];
  static late List<Meal> _mealList = [];
  static late List<MealCollection> _mealCollectionList = [];

  final _userProvider = UserProvider();
  final _workoutProvider = WorkoutProvider();
  final _workoutCategoryProvider = WorkoutCategoryProvider();
  final _collectionCategoryProvider = WorkoutCollectionCategoryProvider();
  final _collectionProvider = WorkoutCollectionProvider();
  final _mealCategoryProvider = MealCategoryProvider();
  final _mealProvider = MealProvider();
  final _mealCollectionProvider = MealCollectionProvider();

  List<Workout> get workoutList => [..._workoutList];
  List<Category> get workoutCateList => [..._workoutCateList];
  List<WorkoutCollection> get collectionList => [..._collectionList];
  List<WorkoutCollection> get userCollectionList => _userCollectionList;
  List<Category> get collectionCateList => [..._collectionCateList];
  List<Category> get mealCategoryList => [..._mealCategories];
  List<Meal> get mealList => [..._mealList];
  List<MealCollection> get mealCollectionList => [..._mealCollectionList];

  loadMealCollectionList() async {
    if (_mealCollectionList.isNotEmpty) return;
    _mealCollectionList = await _mealCollectionProvider.fetchAll();
  }

  loadMealCategoryList() async {
    if (_mealCategories.isNotEmpty) return;
    _mealCategories = await _mealCategoryProvider.fetchAll();
  }

  loadMealList() async {
    if (_mealList.isNotEmpty) return;
    _mealList = await _mealProvider.fetchAll();
  }

  loadUserCollectionList() async {
    _userCollectionList = await _collectionProvider.fetchAllUserCollection();
  }

  Future<ViPTUser?> createUser(ViPTUser user) async {
    currentUser = await _userProvider.add(user);
    return currentUser;
  }

  loadUserData() async {
    currentUser =
        await _userProvider.fetch(AuthService.instance.currentUser!.uid);
  }

  resetUserData() => currentUser = null;

  loadWorkoutList() async {
    if (_workoutList.isNotEmpty) return;
    _workoutList = await _workoutProvider.fetchAll();
  }

  loadWorkoutCategory() async {
    if (_workoutCateList.isNotEmpty) return;
    _workoutCateList = await _workoutCategoryProvider.fetchAll();
  }

  loadCollectionCategoryList() async {
    if (_collectionCateList.isNotEmpty) return;
    _collectionCateList = await _collectionCategoryProvider.fetchAll();
  }

  loadCollectionList() async {
    if (_collectionList.isNotEmpty) return;
    _collectionList = await _collectionProvider.fetchAllDefaultCollection();
  }
}
