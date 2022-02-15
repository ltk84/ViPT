import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/providers/workout_collection_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';

class AddWorkoutCollectionController extends GetxController {
  // add, edit action
  TextEditingController titleTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  List<String> workoutIDs = [];
  RxList<String> selectValueList = <String>[].obs;
  WorkoutCollectionController wkControler =
      Get.find<WorkoutCollectionController>();
  //

  addWorkoutCollection() async {
    WorkoutCollection wkCollection = WorkoutCollection(null,
        title: titleTextController.text,
        description: descriptionTextController.text,
        workoutIDs: workoutIDs,
        categoryIDs: []);
    // DataService.instance.userCollectionList.add(wkCollection);
    wkControler.addUserCollection(wkCollection);
    // await WorkoutCollectionProvider().add(wkCollection);
    Get.back();
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
