import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vipt/app/modules/auth/authentication_binding.dart';
import 'package:vipt/app/modules/auth/screens/authentication_screen.dart';
import 'package:vipt/app/modules/error/screens/error_screen.dart';
import 'package:vipt/app/modules/home/home_binding.dart';
import 'package:vipt/app/modules/home/screens/home_screen.dart';
import 'package:vipt/app/modules/profile/screens/library_screen.dart';
import 'package:vipt/app/modules/setup_info/screens/setup_info_intro_screen.dart';
import 'package:vipt/app/modules/setup_info/screens/setup_info_question_screen.dart';
import 'package:vipt/app/modules/setup_info/setup_info_binding.dart';
import 'package:vipt/app/modules/splash/screens/splash_screen.dart';
import 'package:vipt/app/modules/splash/splash_binding.dart';
import 'package:vipt/app/modules/workout/screens/category_list_screen.dart';
import 'package:vipt/app/modules/workout/screens/exercise_detail_screen.dart';
import 'package:vipt/app/modules/workout/screens/exercise_list_screen.dart';
import 'package:vipt/app/modules/workout/workout_binding.dart';
import 'package:vipt/app/modules/workout_collection/add_workout_collection_binding.dart';
import 'package:vipt/app/modules/workout_collection/screens/add_exercise_to_collection_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/add_workout_collection_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/edit_workout_collection_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/my_workout_collection_detail_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/my_workout_collection_list_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/preview_exercise_list.dart';
import 'package:vipt/app/modules/workout_collection/screens/workout_collection_detail_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/workout_collection_category_list_screen.dart';
import 'package:vipt/app/modules/workout_collection/screens/workout_collection_list_screen.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_binding.dart';

part 'routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(
        name: Routes.splash,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.auth,
      page: () => AuthenticationScreen(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
        name: Routes.home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: Routes.error, page: () => const ErrorScreen()),
    GetPage(
      name: Routes.setupInfoIntro,
      page: () => const SetupInfoIntroScreen(),
      binding: SetupInfoBinding(),
    ),
    GetPage(
      name: Routes.setupInfoQuestion,
      page: () => const SetupInfoQuestionScreen(),
      binding: SetupInfoBinding(),
    ),
    GetPage(
      name: Routes.workoutCategory,
      page: () => CategoryListScreen(),
      binding: WorkoutBinding(),
    ),
    GetPage(
      name: Routes.exerciseList,
      page: () => ExerciseListScreen(),
    ),
    GetPage(
      name: Routes.exerciseDetail,
      page: () => ExerciseDetail(),
    ),
    GetPage(
      name: Routes.workoutCollectionCategory,
      page: () => WorkoutCollectionCategoryListScreen(),
      binding: WorkoutCollectionBinding(),
    ),
    GetPage(
      name: Routes.workoutCollectionList,
      page: () => WorkoutCollectionListScreen(),
    ),
    GetPage(
      name: Routes.myWorkoutCollectionList,
      page: () => MyWorkoutCollectionListScreen(),
    ),
    GetPage(
      name: Routes.workoutCollectionDetail,
      page: () => WorkoutCollectionDetailScreen(),
    ),
    GetPage(
      name: Routes.myWorkoutCollectionDetail,
      page: () => MyWorkoutCollectionDetailScreen(),
    ),
    GetPage(
      name: Routes.library,
      page: () => LibraryScreen(),
    ),
    GetPage(
      name: Routes.addWorkoutCollection,
      page: () => AddWorkoutCollectionScreen(),
      binding: AddWorkoutCollectionBinding(),
    ),
    GetPage(
      name: Routes.editWorkoutCollection,
      page: () => EditWorkoutCollectionScreen(),
      binding: AddWorkoutCollectionBinding(),
    ),
    GetPage(
      name: Routes.addExerciseToCollection,
      page: () => AddExerciseToCollectionScreen(),
    ),
    GetPage(
      name: Routes.previewExerciseList,
      page: () => PreviewExerciseList(),
    ),
  ];
}
