import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vipt/app/core/utilities/utils.dart';
import 'package:vipt/app/core/values/colors.dart';
import 'package:vipt/app/data/providers/exercise_nutrition_route_provider.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class DefaultPlanScreen extends StatelessWidget {
  const DefaultPlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Chưa có lộ trình nào được đề xuất',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
              child: Material(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    await handleCreateRoute();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome_rounded,
                            color: Colors.transparent),
                        Expanded(
                          child: Text(
                            'Đề xuất lộ trình mới',
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: AppColor.accentTextColor,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Icon(Icons.auto_awesome_rounded,
                            color: AppColor.yellowColor),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> handleCreateRoute() async {
    UIUtils.showLoadingDialog();
    await DataService.instance.loadUserData();
    await ExerciseNutritionRouteProvider().resetRoute();
    UIUtils.hideLoadingDialog();
    Get.offAllNamed(Routes.home);
  }
}
