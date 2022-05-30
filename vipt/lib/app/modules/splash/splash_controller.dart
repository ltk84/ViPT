import 'dart:async';

import 'package:get/get.dart';
import 'package:vipt/app/data/services/app_start_service.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/data/services/data_service.dart';
import 'package:vipt/app/routes/pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await AppStartService.instance.initService();
    await Future.delayed(const Duration(seconds: 3), () {});
    await _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    if (AuthService.instance.isLogin) {
      await DataService.instance.loadUserData();
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.auth);
    }
  }
}
