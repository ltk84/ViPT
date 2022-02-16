import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/category.dart';
import 'package:vipt/app/data/models/workout.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/workout_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class AddWorkoutCollectionController extends GetxController {
  // add, edit action
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  List<String> workoutIDs = [];
  RxList<String> selectValueList = <String>[].obs;
  //

  WorkoutCollection? selectedCollection =
      Get.find<WorkoutCollectionController>().selectedCollection;

  TextEditingController searchTextController = TextEditingController();
  RxString searchText = ''.obs;

  List<Workout> searchResult = [
    // Workout('oLrjD5ZIqtIH8XDBJTLK',
    //     name: 'stretching1',
    //     animation: 'animation',
    //     hints: 'hints',
    //     breathing: 'breathing',
    //     muscleFocusAsset: 'muscleFocusAsset',
    //     categoryIDs: ['Rxb89cZTkXtSLvghJeei'],
    //     metValue: 1,
    //     equipmentIDs: [])
  ];

  @override
  void onInit() {
    searchTextController.addListener(() {
      searchText.value = searchTextController.text;
    });

    debounce(searchText, (_) {
      searchResult.clear();

      var key = searchTextController.text;
      List<Workout> nameResult = DataService.instance.workoutList
          .where((wk) => wk.name.contains(key))
          .toList();

      searchResult.addAll(nameResult);
      update();
    }, time: const Duration(seconds: 1));

    super.onInit();
  }

  addWorkoutCollection() async {
    WorkoutCollection wkCollection = WorkoutCollection(null,
        title: titleTextController.text,
        description: descriptionTextController.text,
        workoutIDs: workoutIDs,
        categoryIDs: []);
    Get.back(result: wkCollection);
  }

  beforeEdit() {
    titleTextController.text = selectedCollection!.title;
    descriptionTextController.text = selectedCollection!.description;
    workoutIDs = selectedCollection!.workoutIDs;
  }

  editWorkoutCollection() {
    var editCollection = WorkoutCollection(selectedCollection!.id,
        title: titleTextController.text,
        description: descriptionTextController.text,
        workoutIDs: workoutIDs,
        categoryIDs: []);
    selectedCollection = editCollection;
    Get.back(result: selectedCollection);
  }

  assignForSelectValueList() {
    selectValueList = RxList.from(workoutIDs);
  }

  onSave() {
    workoutIDs = [...selectValueList];
    update();
    Get.back();
    selectValueList.clear();
  }

  handleSelect(String id) {
    if (selectValueList.contains(id)) {
      selectValueList.remove(id);
    } else {
      selectValueList.add(id);
    }
  }

  removeAllWorkoutFromCollection() {
    workoutIDs.clear();
    update();
  }
}
