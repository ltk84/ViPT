import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/workout_collection_provider.dart';
import 'package:vipt/app/data/providers/workout_collection_setting_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/routes/pages.dart';

class WorkoutCollectionController extends GetxController {
  // property
  // list chứa tất cả các collection
  late List<WorkoutCollection> collections;
  // list chứa tất cả các category của các collection
  late List<Category> collectionCategories;
  // map chứa danh sách các cate và các collection tương ứng
  late Map<String, int> cateListAndNumCollection;
  // collection setting của collection được chọn
  late Rx<CollectionSetting> collectionSetting;

  // giá trị calo và value của collection được chọn
  Rx<double> caloValue = 0.0.obs;
  Rx<double> timeValue = 0.0.obs;

  // list collection của user tự tạo
  late List<WorkoutCollection> userCollections;

  // collection được chọn
  WorkoutCollection? selectedCollection;

  // danh sách workout của collection được chọn
  List<Workout> workoutList = [];
  // danh sách workout được tạo ra dựa trên collection setting từ workoutList
  List<Workout> generatedWorkoutList = [];
  // biến ràng buộc dùng trong collectionSetting
  Rx<int> maxWorkout = 100.obs;

  Rx<String> displayTime = ''.obs;

  @override
  void onInit() {
    loadCollectionCategories();
    loadCateListAndNumCollection();
    initCollectionSetting();
    loadUserCollections();
    loadCollectionSetting();
    selectedCollection = null;
    super.onInit();

    ever(collectionSetting, (_) {
      calculateCaloAndTime();
    });
  }

  // method
  // hàm handle khi người dùng chọn vào collection của user tự tạo
  void onSelectUserCollection(WorkoutCollection collection) {
    selectedCollection = collection;
    loadWorkoutListForUserCollection();

    generateRandomList();
  }

  // hàm handle khi người dùng chọn vào collection có sẵn
  void onSelectDefaultCollection(WorkoutCollection collection) {
    selectedCollection = collection;
    loadWorkoutListForDefaultCollection(collection.generatorIDs);

    generateRandomList();
  }

  // hàm random ra generatedList
  generateRandomList() {
    if (workoutList.isEmpty) {
      generatedWorkoutList = [];
      collectionSetting.value.numOfWorkoutPerRound = 0;
    } else {
      maxWorkout.value = workoutList.length;

      if (maxWorkout.value < collectionSetting.value.numOfWorkoutPerRound) {
        collectionSetting.value.numOfWorkoutPerRound = maxWorkout.value;
      }
      workoutList.shuffle();

      generatedWorkoutList =
          workoutList.sublist(0, collectionSetting.value.numOfWorkoutPerRound);
    }

    calculateCaloAndTime();
    update();
  }

  // hàm add 1 user collection
  void addUserCollection(WorkoutCollection wkCollection) async {
    userCollections.add(wkCollection);
    update();
    await WorkoutCollectionProvider().add(wkCollection);
    calculateCaloAndTime();
  }

  // hàm edit 1 user collection
  editUserCollection(WorkoutCollection editedCollection) async {
    selectedCollection = editedCollection;

    final index = userCollections
        .indexWhere((element) => element.id == selectedCollection!.id);
    userCollections[index] = selectedCollection!;

    loadWorkoutListForUserCollection();
    generateRandomList();
    // calculateCaloAndTime();
    update();

    await WorkoutCollectionProvider()
        .update(selectedCollection!.id ?? '', selectedCollection!);
  }

  // hàm edit 1 user collection
  deleteUserCollection() async {
    final result = await showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return CustomConfirmationDialog(
          label: 'Xóa bộ luyện tập',
          content:
              'Bạn có chắc chắn muốn xóa bộ luyện tập này? Bạn sẽ không thể hoàn tác lại thao tác này.',
          labelCancel: 'Không',
          labelOk: 'Có',
          onCancel: () {
            Navigator.of(context).pop();
          },
          onOk: () {
            Navigator.of(context).pop(OkCancelResult.ok);
          },
          primaryButtonColor: AppColor.primaryColor,
          buttonFactorOnMaxWidth: 0.32,
          buttonsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );

    if (result == OkCancelResult.ok) {
      if (selectedCollection!.id == null) return;
      userCollections
          .removeWhere((element) => element.id == selectedCollection!.id);
      await WorkoutCollectionProvider().delete(selectedCollection!.id ?? '');

      calculateCaloAndTime();

      update();
      Get.back();
    }
  }

  // hàm load các user collection
  void loadUserCollections() {
    userCollections = DataService.instance.userCollectionList;
  }

  // hàm load workoutList của user collection
  void loadWorkoutListForUserCollection() {
    workoutList = <Workout>[].obs;
    for (var id in selectedCollection!.generatorIDs) {
      var workout = DataService.instance.workoutList
          .firstWhere((element) => element.id == id);
      workoutList.add(workout);
    }
  }

  // hàm load workoutList của collection có sẵn
  void loadWorkoutListForDefaultCollection(List<String> cateIDs) {
    List<Workout> list = [];
    for (var id in cateIDs) {
      var workouts = DataService.instance.workoutList
          .where((element) => element.categoryIDs.contains(id));
      list.addAll(workouts);
    }

    workoutList = list;
  }

  // hàm reset calo và time
  void resetCaloAndTime() {
    caloValue.value = 0;
    timeValue.value = 0;
  }

  // hàm tính toán calo và time
  void calculateCaloAndTime() {
    num bodyWeight = DataService.currentUser.currentWeight;
    resetCaloAndTime();
    caloValue.value = WorkoutCollectionUtils.calculateCalo(
        workoutList: generatedWorkoutList,
        collectionSetting: collectionSetting.value,
        bodyWeight: bodyWeight);

    timeValue.value = WorkoutCollectionUtils.calculateTime(
        collectionSetting: collectionSetting.value,
        workoutListLength: generatedWorkoutList.length);

    displayTime.value = timeValue.value < 1
        ? '${(timeValue.value * 60).toInt()} giây'
        : '${timeValue.value.toInt()} phút';
  }

  // hàm init collection setting
  void initCollectionSetting() {
    collectionSetting = CollectionSetting().obs;
  }

  // hàm load collection setting
  void loadCollectionSetting() {
    collectionSetting.value = DataService.currentUser.collectionSetting;
  }

  // hàm update collection setting
  Future<void> updateCollectionSetting() async {
    await WorkoutCollectionSettingProvider()
        .update('id', collectionSetting.value);
  }

  // hàm load cateListAndNumCollection
  void loadCateListAndNumCollection() {
    cateListAndNumCollection = DataService.instance.cateListAndNumCollection;
  }

  // hàm load category của các collection
  void loadCollectionCategories() {
    collectionCategories = DataService.instance.collectionCateList
        .where((element) => element.parentCategoryID == null)
        .toList();
  }

  // hàm init list collection
  void initCollections() {
    collections = [];
  }

  // hàm load list collection dựa trên cate
  void loadCollectionListBaseOnCategory(Category cate) {
    collections = DataService.instance.collectionList
        .where((collection) => collection.categoryIDs.contains(cate.id))
        .toList();
    Get.toNamed(Routes.workoutCollectionList, arguments: cate);
  }

  // hàm load list cate con dựa trên cate cha
  void loadChildCategoriesBaseOnParentCategory(String categoryID) {
    collectionCategories = DataService.instance.collectionCateList
        .where((element) => element.parentCategoryID == categoryID)
        .toList();
    Get.toNamed(Routes.workoutCollectionCategory, preventDuplicates: false);
  }
}
