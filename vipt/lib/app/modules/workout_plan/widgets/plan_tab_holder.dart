import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/values/asset_strings.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/models/collection_setting.dart';
import 'package:vipt/app/data/models/meal_nutrition.dart';
import 'package:vipt/app/data/models/nutrition.dart';
import 'package:vipt/app/data/models/workout_collection.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/global_widgets/custom_confirmation_dialog.dart';
import 'package:vipt/app/global_widgets/loading_widget.dart';
import 'package:vipt/app/modules/nutrition/nutrition_controller.dart';
import 'package:vipt/app/modules/workout_collection/widgets/exercise_in_collection_tile.dart';
import 'package:vipt/app/modules/workout_collection/workout_collection_controller.dart';
import 'package:vipt/app/modules/workout_plan/screens/all_plan_exercise_screen.dart';
import 'package:vipt/app/modules/workout_plan/screens/all_plan_nutrition.screen.dart';
import 'package:vipt/app/routes/pages.dart';

import '../workout_plan_controller.dart';

class PlanTabHolder extends StatefulWidget {
  const PlanTabHolder({Key? key}) : super(key: key);

  @override
  State<PlanTabHolder> createState() => _PlanTabHolderState();
}

class _PlanTabHolderState extends State<PlanTabHolder>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  final _controller = Get.find<WorkoutPlanController>();

  List<WorkoutCollection> workouts = [];
  List<MealNutrition> meals = [];
  List<WorkoutCollection> allWorkouts = [];
  List<MealNutrition> allMeals = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();

    workouts = _controller.loadWorkoutCollectionToShow(DateTime.now());
    allWorkouts = _controller.loadAllWorkoutCollection();
    _controller.loadMealListToShow(DateTime.now()).then((value) => setState(() {
          meals = value;
        }));
    _controller.loadAllMealList().then((value) {
      setState(() {
        allMeals = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: TabBar(
            controller: _tabController,
            onTap: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            labelStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            tabs: const [
              Tab(
                text: 'Luyện tập',
              ),
              Tab(
                text: 'Ăn uống',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Builder(builder: (_) {
          if (_selectedTabIndex == 0) {
            return Column(
              children: [
                ..._buildCollectionList(
                  workoutCollectionList: workouts,
                  elementOnPress: (col) async {
                    await _handleSelectExercise(col);
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    child: Text(
                      'Xem tất cả các ngày',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            fontSize: 16,
                            color: AppColor.primaryColor,
                          ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return AllPlanExerciseScreen(
                            startDate:
                                _controller.currentWorkoutPlan!.startDate,
                            workoutCollectionList: allWorkouts,
                            elementOnPress: (col) async {
                              await _handleSelectExercise(col);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Obx(
              () => _controller.isTodayMealListLoading.value
                  ? const Padding(
                      padding: EdgeInsets.all(24.0), child: LoadingWidget())
                  : Column(
                      children: [
                        ..._buildNutritionList(
                          nutritionList: meals,
                          elementOnPress: (nutri) async {
                            await handleSelectMeal(nutri);
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            child: Text(
                              'Xem tất cả các ngày',
                              style:
                                  Theme.of(context).textTheme.button!.copyWith(
                                        fontSize: 16,
                                        color: AppColor.primaryColor,
                                      ),
                            ),
                            onPressed: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return Obx(
                                    () => AllPlanNutritionScreen(
                                      isLoading: _controller
                                          .isAllMealListLoading.value,
                                      nutritionList: allMeals,
                                      startDate: _controller
                                          .currentWorkoutPlan!.startDate,
                                      elementOnPress: (nutri) async {
                                        await handleSelectMeal(nutri);
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            );
          }
        }),
      ],
    );
  }

  _handleSelectExercise(WorkoutCollection col) async {
    final _collectionController = Get.put(WorkoutCollectionController());
    _collectionController.useDefaulColSetting = false;
    CollectionSetting? colSetting =
        _controller.getCollectionSetting(col.id ?? '');
    if (colSetting != null) {
      _collectionController.collectionSetting.value =
          CollectionSetting.fromCollectionSetting(colSetting);
      _collectionController.onSelectUserCollection(col);
      await Get.toNamed(Routes.myWorkoutCollectionDetail);
      await Get.delete<WorkoutCollectionController>();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomConfirmationDialog(
            icon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Icon(Icons.error_rounded,
                  color: AppColor.errorColor, size: 48),
            ),
            label: 'Đã xảy ra lỗi',
            content: 'Không tìm thấy cài đặt bộ luyện tập',
            showOkButton: false,
            labelCancel: 'Đóng',
            onCancel: () {
              Navigator.of(context).pop();
            },
            buttonsAlignment: MainAxisAlignment.center,
            buttonFactorOnMaxWidth: double.infinity,
          );
        },
      );
    }
  }

  handleSelectMeal(MealNutrition nutrition) async {
    Get.put(NutritionController());
    await Get.toNamed(Routes.dishDetail, arguments: nutrition);
    await Get.delete<NutritionController>();
  }

  _buildCollectionList(
      {required List<WorkoutCollection> workoutCollectionList,
      required Function(WorkoutCollection) elementOnPress}) {
    int collectionPerDay = 4;
    List<Widget> results = [];

    int count = workoutCollectionList.length;
    for (int i = 0; i < count; i++) {
      WorkoutCollection collection = workoutCollectionList[i];
      String cateList = DataService.instance.collectionCateList
          .where((item) => collection.categoryIDs.contains(item.id))
          .map((e) => e.name)
          .toString()
          .replaceAll(RegExp(r'\(|\)'), '');

      Widget collectionToWidget = Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ExerciseInCollectionTile(
            asset: collection.asset == ''
                ? JPGAssetString.userWorkoutCollection
                : collection.asset,
            title: collection.title,
            description: cateList,
            onPressed: () {
              elementOnPress(collection);
            }),
      );

      if (i % collectionPerDay == 0) {
        Widget dayIndicator = Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  Text(
                    'NGÀY ${i ~/ collectionPerDay + 1}',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.textColor.withOpacity(
                            AppColor.subTextOpacity,
                          ),
                        ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
            ],
          ),
        );

        results.add(dayIndicator);
      }

      results.add(collectionToWidget);
    }

    return results;
  }

  _buildNutritionList(
      {required List<MealNutrition> nutritionList,
      required Function(MealNutrition) elementOnPress}) {
    int collectionPerDay = 3;
    List<Widget> results = [];

    int count = nutritionList.length;
    for (int i = 0; i < count; i++) {
      Nutrition nutrition = nutritionList[i];

      Widget collectionToWidget = Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ExerciseInCollectionTile(
            asset: (nutrition as MealNutrition).meal.asset == ''
                ? JPGAssetString.meal
                : nutrition.meal.asset,
            title: nutrition.getName(),
            description: nutrition.calories.toStringAsFixed(0) + ' kcal',
            onPressed: () {
              elementOnPress(nutrition);
            }),
      );

      if (i % collectionPerDay == 0) {
        Widget dayIndicator = Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(
                  //   height: 24,
                  // ),
                  Text(
                    'NGÀY ${i ~/ collectionPerDay + 1}',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: AppColor.textColor.withOpacity(
                            AppColor.subTextOpacity,
                          ),
                        ),
                  ),
                  // const SizedBox(
                  //   height: 4,
                  // ),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: AppColor.textFieldUnderlineColor,
                ),
              ),
            ],
          ),
        );

        results.add(dayIndicator);
      }

      results.add(collectionToWidget);
    }

    return results;
  }
}
