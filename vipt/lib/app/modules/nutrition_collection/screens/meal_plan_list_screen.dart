import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vipt/app/data/models/meal.dart';
import 'package:vipt/app/data/models/meal_collection.dart';
import 'package:vipt/app/modules/nutrition_collection/widgets/meal_plan_tile.dart';
import 'package:vipt/app/routes/pages.dart';

class MealPlanListScreen extends StatelessWidget {
  const MealPlanListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MealCollection> mealCollections = [
      MealCollection(
          id: '0',
          title: 'Ăn chay',
          description:
              'Các bữa ăn trong chế độ này chỉ bao gồm các thành phần từ rau củ quả.',
          note: '',
          asset:
              'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
          dateToMeal: {
            1: [
              Meal(
                  id: '0',
                  name: 'Cứt',
                  asset:
                      'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
                  cookTime: 15,
                  ingreIDToAmount: {},
                  steps: [],
                  categoryIDs: []),
              Meal(
                  id: '0',
                  name: 'Cứt2',
                  asset:
                      'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
                  cookTime: 15,
                  ingreIDToAmount: {},
                  steps: [],
                  categoryIDs: []),
            ],
            2: [
              Meal(
                  id: '0',
                  name: 'Cứt3',
                  asset:
                      'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
                  cookTime: 15,
                  ingreIDToAmount: {},
                  steps: [],
                  categoryIDs: []),
            ]
          }),
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.5,
        leading: IconButton(
          icon: const Hero(
            tag: 'leadingButtonAppBar',
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Hero(
          tag: 'titleAppBar',
          child: Text(
            'Kế hoạch dinh dưỡng'.tr,
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      body: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount: mealCollections.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                MealPlanTile(
                  onPressed: () {
                    Get.toNamed(Routes.mealPlanDetail,
                        arguments: mealCollections[index]);
                  },
                  asset:
                      'https://drive.google.com/uc?export=view&id=1IADpSHhDQ6vGcPAOSiwjigh72CI3LIb7',
                  title: mealCollections[index].title,
                  description:
                      '${mealCollections[index].dateToMeal.length} ngày'.tr,
                ),
                const Divider(
                  indent: 24,
                ),
              ],
            );
          }),
    );
  }
}
