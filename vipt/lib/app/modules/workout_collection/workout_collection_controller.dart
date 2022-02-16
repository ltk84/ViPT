import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/workout_collection_provider.dart';
import 'package:vipt/app/data/providers/workout_collection_setting_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionController extends GetxController {
  late List<WorkoutCollection> collections;
  late List<Category> collectionCategories;
  late Map<String, int> cateListAndNumCollection;
  late Rx<CollectionSetting> collectionSetting;
  Rx<double> caloValue = 0.0.obs;
  Rx<double> timeValue = 0.0.obs;
  late List<WorkoutCollection> userCollections;

  WorkoutCollection? selectedCollection;
  late List<Workout> workoutList;

  @override
  void onInit() {
    loadCollectionCategories();
    initCollections();
    loadCateListAndNumCollection();
    initCollectionSetting();
    loadUserCollections();
    selectedCollection = null;
    super.onInit();

    ever(collectionSetting, (_) {
      calculateCaloAndTime();
    });
  }

  void onSelectCollection(WorkoutCollection collection) {
    selectedCollection = collection;
    loadWorkoutListForUserCollection();
    calculateCaloAndTime();
  }

  void addUserCollection(WorkoutCollection wkCollection) async {
    userCollections.add(wkCollection);
    update();
    await WorkoutCollectionProvider().add(wkCollection);
    calculateCaloAndTime();
  }

  editUserCollection(WorkoutCollection editedCollection) async {
    selectedCollection = editedCollection;

    final index = userCollections
        .indexWhere((element) => element.id == selectedCollection!.id);
    userCollections[index] = selectedCollection!;

    loadWorkoutListForUserCollection();
    update();
    await WorkoutCollectionProvider()
        .update(selectedCollection!.id ?? '', selectedCollection!);
  }

  deleteUserCollection() async {
    final result = await showOkCancelAlertDialog(
        context: Get.context!,
        title: 'Xóa bộ luyện tập',
        message:
            'Bạn có chắc chắn muốn xóa bộ luyện tập này? Bạn sẽ không thể hoàn tác lại thao tác này.',
        okLabel: 'Có',
        cancelLabel: 'Không');

    if (result == OkCancelResult.ok) {
      if (selectedCollection!.id == null) return;
      userCollections
          .removeWhere((element) => element.id == selectedCollection!.id);
      await WorkoutCollectionProvider().delete(selectedCollection!.id ?? '');
      update();
      Get.back();
    }
  }

  void loadUserCollections() {
    userCollections = DataService.instance.userCollectionList;
  }

  void loadWorkoutListForUserCollection() {
    workoutList = <Workout>[].obs;
    for (var id in selectedCollection!.workoutIDs) {
      var workout = DataService.instance.workoutList
          .firstWhere((element) => element.id == id);
      workoutList.add(workout);
      update();
    }
  }

  List<Workout> loadWorkoutList(List<String> workoutIDs) {
    List<Workout> list = [];
    for (var id in workoutIDs) {
      var workout = DataService.instance.workoutList
          .firstWhere((element) => element.id == id);
      list.add(workout);
    }

    return list;
  }

  void resetCaloAndTime() {
    caloValue.value = 0;
    timeValue.value = 0;
  }

  void calculateCaloAndTime() {
    num bodyWeight = DataService.currentUser.currentWeight;
    resetCaloAndTime();
    caloValue.value = WorkoutCollectionUtils.calculateCalo(
        workoutList: workoutList,
        collectionSetting: collectionSetting.value,
        bodyWeight: bodyWeight);

    timeValue.value = WorkoutCollectionUtils.calculateTime(
        collectionSetting: collectionSetting.value,
        workoutListLenght: workoutList.length);
  }

  void initCollectionSetting() {
    collectionSetting = CollectionSetting().obs;
  }

  void loadCollectionSetting() {
    collectionSetting.value = DataService.currentUser.collectionSetting;
  }

  Future<void> updateCollectionSetting() async {
    await WorkoutCollectionSettingProvider()
        .update('id', collectionSetting.value);
  }

  void loadCateListAndNumCollection() {
    cateListAndNumCollection = DataService.instance.cateListAndNumCollection;
  }

  void loadCollectionCategories() {
    collectionCategories = DataService.instance.collectionCateList
        .where((element) => element.parentCategoryID == null)
        .toList();
  }

  void initCollections() {
    collections = [];
  }

  void loadCollectionListBaseOnCategory(Category cate) {
    collections = DataService.instance.collectionList
        .where((collection) => collection.categoryIDs.contains(cate.id))
        .toList();
    Get.toNamed(Routes.workoutCollectionList, arguments: cate);
  }

  void loadChildCategoriesBaseOnParentCategory(String categoryID) {
    collectionCategories = DataService.instance.collectionCateList
        .where((element) => element.parentCategoryID == categoryID)
        .toList();
    Get.toNamed(Routes.workoutCollectionCategory, preventDuplicates: false);
  }
}
