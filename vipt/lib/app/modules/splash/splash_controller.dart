import 'package:get/get.dart';
import 'package:vipt/app/data/services/app_start_service.dart';
import 'package:vipt/app/data/services/auth_service.dart';
import 'package:vipt/app/routes/pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await AppStartService.instance.initFirebase();
    super.onInit();
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
