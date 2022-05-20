import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:vipt/app/data/models/vipt_user.dart';
import 'package:vipt/app/data/providers/user_provider.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/modules/daily_plan/daily_plan_controller.dart';
import 'package:vipt/app/modules/library/library_controller.dart';
import 'package:vipt/app/modules/profile/profile_controller.dart';
import 'package:vipt/app/modules/workout_plan/workout_plan_controller.dart';
import 'package:vipt/app/routes/pages.dart';

class HomeController extends GetxController {
  static const int workoutPlanTabIndex = 0;
  static const int dailyPlanTabIndex = 1;
  static const int libraryTabIndex = 2;
  static const int profileTabIndex = 3;
  // int currentTabIndex = workoutPlanTabIndex;

  @override
  Future<void> onInit() async {
    await _initControllerForTabs();
    super.onInit();
    tabController.addListener(() {
      switch (tabController.index) {
        case 0:
          Get.find<WorkoutPlanController>().onInit();
          break;
        case 1:
          Get.find<DailyPlanController>().onInit();
          break;
        case 2:
          Get.find<LibraryController>().onInit();
          break;
        case 3:
          Get.find<ProfileController>().onInit();
          break;
        default:
      }
    });
  }

  Future<void> _initControllerForTabs() async {
    Get.lazyPut(() => WorkoutPlanController());
    Get.lazyPut(() => DailyPlanController());
    Get.lazyPut(() => LibraryController());
    Get.lazyPut(() => ProfileController());
  }

  final PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);

  Future<ViPTUser> fetchUserData() async {
    return await UserProvider().fetch('xxhRe9z3WrVaUqwiTwEloL1N4oU2');
  }

  Future<void> signOut() async {
    await AuthService.instance.signOut();
    Get.offAllNamed(Routes.auth);
  }
}
