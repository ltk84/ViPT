import 'dart:async';

import 'package:get/get.dart';
import 'package:vipt/app/data/services/app_start_service.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/routes/pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await AppStartService.instance.initService();
    await Future.delayed(const Duration(seconds: 3), () {});
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    if (AuthService.instance.isLogin) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offAllNamed(Routes.auth);
    }
  }
}
