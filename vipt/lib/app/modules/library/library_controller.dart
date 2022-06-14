import 'package:get/get.dart';
import 'package:vipt/app/data/services/data_service.dart';

class LibraryController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await DataService.instance.loadWorkoutCategory();
    await DataService.instance.loadWorkoutList();
    await DataService.instance.loadCollectionCategoryList();
    await DataService.instance.loadCollectionList();
    await DataService.instance.loadUserCollectionList();
    await DataService.instance.loadMealCategoryList();
    await DataService.instance.loadMealList();
    await DataService.instance.loadMealCollectionList();
  }
}
